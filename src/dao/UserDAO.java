package dao;

import model.User;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    private static final String BASE_URL = "http://localhost:8080/RoomReservation/api/users";

    public User authenticateUser(String username, String password) {
        try {
            String response = sendGet("action=authenticate&username=" + encode(username)
                    + "&password=" + encode(password));
            if (response == null || response.trim().equals("null"))
                return null;
            return parseUser(response);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public User getUserByUsername(String username) {
        try {
            String response = sendGet("action=getByUsername&username=" + encode(username));
            if (response == null || response.trim().equals("null"))
                return null;
            return parseUser(response);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public boolean registerUser(User user) {
        try {
            String params = "action=register"
                    + "&username=" + encode(user.getUsername())
                    + "&password=" + encode(user.getPassword())
                    + "&role=" + encode(user.getRole())
                    + "&fullName=" + encode(user.getFullName())
                    + "&email=" + encode(user.getEmail())
                    + "&phone=" + encode(user.getPhone());
            String response = sendPost(params);
            return response.contains("\"success\":true");
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateUser(User user) {
        try {
            String params = "action=update"
                    + "&userId=" + user.getUserId()
                    + "&username=" + encode(user.getUsername())
                    + "&password=" + encode(user.getPassword())
                    + "&fullName=" + encode(user.getFullName())
                    + "&email=" + encode(user.getEmail())
                    + "&phone=" + encode(user.getPhone());
            String response = sendPost(params);
            return response.contains("\"success\":true");
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean emailExists(String email) {
        try {
            String response = sendGet("action=emailExists&email=" + encode(email));
            return response.contains("true");
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean usernameExists(String username) {
        try {
            String response = sendGet("action=usernameExists&username=" + encode(username));
            return response.contains("true");
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<User> getAllUsers() {
        try {
            String response = sendGet("action=getAll");
            return parseUserList(response);
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    public int getTotalUsers() {
        return getIntValue("action=totalUsers");
    }

    public int getAdminCount() {
        return getIntValue("action=adminCount");
    }

    public int getStaffCount() {
        return getIntValue("action=staffCount");
    }

    private int getIntValue(String params) {
        try {
            String response = sendGet(params);
            String val = extractJsonValue(response, "value");
            if (val == null || val.trim().isEmpty())
                return 0;
            return (int) Double.parseDouble(val);
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    private String sendGet(String params) throws Exception {
        URL url = URI.create(BASE_URL + "?" + params).toURL();
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setConnectTimeout(5000);
        conn.setReadTimeout(5000);
        return readResponse(conn);
    }

    private String sendPost(String params) throws Exception {
        URL url = URI.create(BASE_URL).toURL();
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setDoOutput(true);
        conn.setConnectTimeout(5000);
        conn.setReadTimeout(5000);
        conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
        try (OutputStream os = conn.getOutputStream()) {
            os.write(params.getBytes("UTF-8"));
            os.flush();
        }
        return readResponse(conn);
    }

    private String readResponse(HttpURLConnection conn) throws Exception {
        int status = conn.getResponseCode();
        InputStream is;
        if (status >= 400) {
            is = conn.getErrorStream();
        } else {
            is = conn.getInputStream();
        }

        if (is == null)
            return "";

        try (BufferedReader br = new BufferedReader(new InputStreamReader(is, "UTF-8"))) {
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = br.readLine()) != null) {
                sb.append(line);
            }
            return sb.toString();
        } finally {
            conn.disconnect();
        }
    }

    private static String encode(String s) {
        try {
            return URLEncoder.encode(s != null ? s : "", "UTF-8");
        } catch (Exception e) {
            return s;
        }
    }

    private User parseUser(String json) {
        try {
            User u = new User();
            u.setUserId(Integer.parseInt(extractJsonValue(json, "userId")));
            u.setUsername(extractJsonStringValue(json, "username"));
            u.setPassword(extractJsonStringValue(json, "password"));
            u.setRole(extractJsonStringValue(json, "role"));
            u.setFullName(extractJsonStringValue(json, "fullName"));
            u.setEmail(extractJsonStringValue(json, "email"));
            u.setPhone(extractJsonStringValue(json, "phone"));
            u.setStatus(extractJsonStringValue(json, "status"));
            return u;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    private List<User> parseUserList(String json) {
        List<User> list = new ArrayList<>();
        if (json == null || json.trim().equals("[]"))
            return list;
        json = json.trim();
        if (json.startsWith("["))
            json = json.substring(1);
        if (json.endsWith("]"))
            json = json.substring(0, json.length() - 1);
        int depth = 0;
        int start = 0;
        for (int i = 0; i < json.length(); i++) {
            char c = json.charAt(i);
            if (c == '{')
                depth++;
            else if (c == '}') {
                depth--;
                if (depth == 0) {
                    String obj = json.substring(start, i + 1).trim();
                    if (obj.startsWith(","))
                        obj = obj.substring(1).trim();
                    User u = parseUser(obj);
                    if (u != null)
                        list.add(u);
                    start = i + 1;
                }
            }
        }
        return list;
    }

    private String extractJsonValue(String json, String key) {
        String search = "\"" + key + "\":";
        int idx = json.indexOf(search);
        if (idx < 0)
            return "";
        int start = idx + search.length();
        if (json.charAt(start) == '"') {
            int end = json.indexOf('"', start + 1);
            return json.substring(start + 1, end);
        } else {
            int end = start;
            while (end < json.length() && json.charAt(end) != ',' && json.charAt(end) != '}')
                end++;
            return json.substring(start, end).trim();
        }
    }

    private String extractJsonStringValue(String json, String key) {
        String search = "\"" + key + "\":\"";
        int idx = json.indexOf(search);
        if (idx < 0)
            return "";
        int start = idx + search.length();
        int end = start;
        while (end < json.length()) {
            if (json.charAt(end) == '\\') {
                end += 2;
                continue;
            }
            if (json.charAt(end) == '"')
                break;
            end++;
        }
        String val = json.substring(start, end);
        return val.replace("\\\"", "\"").replace("\\\\", "\\").replace("\\n", "\n").replace("\\r", "\r");
    }
}

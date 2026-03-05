package dao;

import model.Reservation;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URL;
import java.net.URLEncoder;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

public class ReservationDAO {

   private static final String BASE_URL = "http://localhost:8080/RoomReservation/api/reservations";

    public boolean addReservation(Reservation reservation) {
        try {
            String params = "action=add"
                    + "&reservationId=" + reservation.getReservationId()
                    + "&guestName=" + encode(reservation.getGuestName())
                    + "&address=" + encode(reservation.getAddress())
                    + "&contact=" + encode(reservation.getContact())
                    + "&roomType=" + encode(reservation.getRoomType())
                    + "&checkIn=" + reservation.getCheckIn()
                    + "&checkOut=" + reservation.getCheckOut()
                    + "&totalBill=" + reservation.getTotalBill();
            String response = sendPost(params);
            return response.contains("\"success\":true");
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public Reservation searchReservation(int reservationId) {
        try {
            String response = sendGet("action=search&id=" + reservationId);
            if (response == null || response.trim().equals("null"))
                return null;
            return parseReservation(response);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public List<Reservation> searchByGuestName(String guestName) {
        try {
            String response = sendGet("action=searchByName&name=" + encode(guestName));
            return parseReservationList(response);
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    public boolean updateReservation(Reservation reservation) {
        try {
            String params = "action=update"
                    + "&reservationId=" + reservation.getReservationId()
                    + "&guestName=" + encode(reservation.getGuestName())
                    + "&address=" + encode(reservation.getAddress())
                    + "&contact=" + encode(reservation.getContact())
                    + "&roomType=" + encode(reservation.getRoomType())
                    + "&checkIn=" + reservation.getCheckIn()
                    + "&checkOut=" + reservation.getCheckOut()
                    + "&totalBill=" + reservation.getTotalBill();
            String response = sendPost(params);
            return response.contains("\"success\":true");
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteReservation(int reservationId) {
        try {
            String response = sendPost("action=delete&id=" + reservationId);
            return response.contains("\"success\":true");
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Reservation> getAllReservations() {
        try {
            String response = sendGet("action=getAll");
            return parseReservationList(response);
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    public int getTotalReservations() {
        return getIntValue("action=totalReservations");
    }

    public int getActiveBookings() {
        return getIntValue("action=activeBookings");
    }

    public double getTotalRevenue() {
        return getDoubleValue("action=totalRevenue");
    }

    public int getTodayCheckIns() {
        return getIntValue("action=todayCheckIns");
    }

    public int getTodayCheckOuts() {
        return getIntValue("action=todayCheckOuts");
    }

    public int getMonthlyBookings() {
        return getIntValue("action=monthlyBookings");
    }

    public double getMonthlyRevenue() {
        return getDoubleValue("action=monthlyRevenue");
    }

    public int getBookedCountByRoomType(String roomType) {
        return getIntValue("action=bookedCountByRoomType&roomType=" + encode(roomType));
    }

    public int getBookedCountByRoomTypeAndDateRange(String roomType, Date checkIn, Date checkOut) {
        return getIntValue("action=bookedCountByRoomTypeAndDateRange&roomType=" + encode(roomType)
                + "&checkIn=" + checkIn + "&checkOut=" + checkOut);
    }

    public double getRevenueByRoomType(String roomType) {
        return getDoubleValue("action=revenueByRoomType&roomType=" + encode(roomType));
    }

    public int getBookingCountByRoomType(String roomType) {
        return getIntValue("action=bookingCountByRoomType&roomType=" + encode(roomType));
    }

    public int getTotalNightsByRoomType(String roomType) {
        return getIntValue("action=totalNightsByRoomType&roomType=" + encode(roomType));
    }

    private int getIntValue(String params) {
        try {
            String response = sendGet(params);
            return parseIntFromJson(response);
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    private double getDoubleValue(String params) {
        try {
            String response = sendGet(params);
            return parseDoubleFromJson(response);
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
        BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = br.readLine()) != null) {
            sb.append(line);
        }
        br.close();
        conn.disconnect();
        return sb.toString();
    }

    private static String encode(String s) {
        try {
            return URLEncoder.encode(s != null ? s : "", "UTF-8");
        } catch (Exception e) {
            return s;
        }
    }

    private int parseIntFromJson(String json) {
        try {
            String val = extractJsonValue(json, "value");
            return (int) Double.parseDouble(val);
        } catch (Exception e) {
            return 0;
        }
    }

    private double parseDoubleFromJson(String json) {
        try {
            String val = extractJsonValue(json, "value");
            return Double.parseDouble(val);
        } catch (Exception e) {
            return 0;
        }
    }

    private Reservation parseReservation(String json) {
        try {
            Reservation r = new Reservation();
            r.setReservationId(Integer.parseInt(extractJsonValue(json, "reservationId")));
            r.setGuestName(extractJsonStringValue(json, "guestName"));
            r.setAddress(extractJsonStringValue(json, "address"));
            r.setContact(extractJsonStringValue(json, "contact"));
            r.setRoomType(extractJsonStringValue(json, "roomType"));
            r.setCheckIn(Date.valueOf(extractJsonStringValue(json, "checkIn")));
            r.setCheckOut(Date.valueOf(extractJsonStringValue(json, "checkOut")));
            r.setTotalBill(Double.parseDouble(extractJsonValue(json, "totalBill")));
            return r;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    private List<Reservation> parseReservationList(String json) {
        List<Reservation> list = new ArrayList<>();
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
                    Reservation r = parseReservation(obj);
                    if (r != null)
                        list.add(r);
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

package service;

import dao.UserDAO;
import model.User;
import java.util.List;

public class UserService {

    private UserDAO userDAO = new UserDAO();

    public User authenticateUser(String username, String password) {
        return userDAO.authenticateUser(username, password);
    }

    public User getUserByUsername(String username) {
        return userDAO.getUserByUsername(username);
    }

    public boolean registerUser(User user) {
        return userDAO.registerUser(user);
    }

    public boolean emailExists(String email) {
        return userDAO.emailExists(email);
    }

    public boolean usernameExists(String username) {
        return userDAO.usernameExists(username);
    }

    public List<User> getAllUsers() {
        return userDAO.getAllUsers();
    }

    public int getTotalUsers() {
        return userDAO.getTotalUsers();
    }

    public int getAdminCount() {
        return userDAO.getAdminCount();
    }

    public int getStaffCount() {
        return userDAO.getStaffCount();
    }

    public boolean updateUser(User user) {
        return userDAO.updateUser(user);
    }

    public static String escapeJson(String s) {
        if (s == null)
            return "";
        return s.replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("'", "\\'")
                .replace("\n", "\\n")
                .replace("\r", "\\r");
    }

    public static String userToJson(User u) {
        if (u == null)
            return "null";
        return "{\"userId\":" + u.getUserId() +
                ",\"username\":\"" + escapeJson(u.getUsername()) + "\"" +
                ",\"password\":\"" + escapeJson(u.getPassword()) + "\"" +
                ",\"role\":\"" + escapeJson(u.getRole()) + "\"" +
                ",\"fullName\":\"" + escapeJson(u.getFullName()) + "\"" +
                ",\"email\":\"" + escapeJson(u.getEmail()) + "\"" +
                ",\"phone\":\"" + escapeJson(u.getPhone()) + "\"" +
                ",\"status\":\"" + escapeJson(u.getStatus()) + "\"}";
    }

    public static String userListToJson(List<User> list) {
        StringBuilder sb = new StringBuilder("[");
        for (int i = 0; i < list.size(); i++) {
            if (i > 0)
                sb.append(",");
            sb.append(userToJson(list.get(i)));
        }
        sb.append("]");
        return sb.toString();
    }
}

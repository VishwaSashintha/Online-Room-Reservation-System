<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="model.User" %>
        <% if (session==null || session.getAttribute("user")==null) { response.sendRedirect("login.jsp"); return; } User
            user=(User) session.getAttribute("user"); if (user !=null && "ADMIN" .equals(user.getRole())) {
            response.sendRedirect("adminDashboard.jsp"); } else { response.sendRedirect("staffDashboard.jsp"); } %>
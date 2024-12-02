<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="util.DBConnection" %>
<%
    // 로그인 체크
    if(session.getAttribute("user_id") == null) {
        response.sendRedirect("main.jsp?error=login");
        return;
    }

    request.setCharacterEncoding("UTF-8");
    
    // 폼 데이터 받기
    String title = request.getParameter("title");
    String content = request.getParameter("content");
    int typeId = Integer.parseInt(request.getParameter("type_id"));
    String userId = (String)session.getAttribute("user_id");
    
    Connection conn = null;
    PreparedStatement pstmt = null;
    
    try {
        conn = DBConnection.getConnection();
        
        String sql = "INSERT INTO Inquiries (type_id, user_id, title, content, created_at, status) VALUES (?, ?, ?, ?, NOW(), 'PENDING')";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, typeId);
        pstmt.setString(2, userId);
        pstmt.setString(3, title);
        pstmt.setString(4, content);
        
        pstmt.executeUpdate();
        response.sendRedirect("inquiry.jsp?write=success");
        
    } catch(Exception e) {
        e.printStackTrace();
        response.sendRedirect("write_inquiry.jsp?error=database");
    } finally {
        DBConnection.close(pstmt, conn);
    }
%> 
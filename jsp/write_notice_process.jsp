<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="util.DBConnection" %>
<%
    // 관리자 권한 체크
    if(session.getAttribute("role") == null || !"ADMIN".equals(session.getAttribute("role"))) {
        response.sendRedirect("main.jsp");
        return;
    }

    request.setCharacterEncoding("UTF-8");
    
    // 폼 데이터 받기
    String title = request.getParameter("title");
    String content = request.getParameter("content");
    int typeId = Integer.parseInt(request.getParameter("type_id")); // 공지 유형
    String userId = (String)session.getAttribute("user_id");
    
    Connection conn = null;
    PreparedStatement pstmt = null;
    
    try {
        conn = DBConnection.getConnection();
        
        String sql = "INSERT INTO Notices (type_id, user_id, title, content, created_at) VALUES (?, ?, ?, ?, NOW())";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, typeId);
        pstmt.setString(2, userId);
        pstmt.setString(3, title);
        pstmt.setString(4, content);
        
        pstmt.executeUpdate();
        response.sendRedirect("notice.jsp?write=success");
        
    } catch(Exception e) {
        e.printStackTrace();
        response.sendRedirect("write_notice.jsp?error=database");
    } finally {
        DBConnection.close(pstmt, conn);
    }
%>
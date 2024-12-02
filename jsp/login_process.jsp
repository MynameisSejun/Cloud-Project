<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="util.DBConnection" %>

<%
    // 폼에서 전송된 데이터 받기
    String userId = request.getParameter("userId");
    String password = request.getParameter("password");

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        conn = DBConnection.getConnection();
        
        // 사용자 확인 쿼리 (role 컬럼 추가)
        String sql = "SELECT user_id, name, role FROM Users WHERE user_id = ? AND password = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, userId);
        pstmt.setString(2, password);
        
        rs = pstmt.executeQuery();
        
        if(rs.next()) {
            // 로그인 성공 시 세션에 사용자 정보 저장
            session.setAttribute("user_id", userId);
            session.setAttribute("user_name", rs.getString("name"));
            session.setAttribute("role", rs.getString("role")); // role 정보 추가
            response.sendRedirect("main.jsp?login=success");
        } else {
            // 로그인 실패
            response.sendRedirect("main.jsp?error=invalid");
        }
        
    } catch(Exception e) {
        // 오류 발생
        e.printStackTrace();
        response.sendRedirect("main.jsp?error=database");
    } finally {
        DBConnection.close(rs, pstmt, conn);
    }
%> 
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="util.DBConnection" %>
<%
    // 문자 인코딩 설정
    request.setCharacterEncoding("UTF-8");

    // 폼에서 전송된 데이터 받기
    String userId = request.getParameter("userId");
    String password = request.getParameter("password");
    String name = request.getParameter("name");
    
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    
    try {
        conn = DBConnection.getConnection();
        
        // 아이디 중복 체크
        String checkSql = "SELECT COUNT(*) FROM Users WHERE user_id = ?";
        pstmt = conn.prepareStatement(checkSql);
        pstmt.setString(1, userId);
        rs = pstmt.executeQuery();
        rs.next();
        
        if(rs.getInt(1) > 0) {
            // 중복된 아이디가 있는 경우
            response.sendRedirect("main.jsp?error=duplicate");
            return;
        }
        
        // 기존 PreparedStatement 닫기
        if(pstmt != null) pstmt.close();
        
        // 회원 정보 삽입
        String sql = "INSERT INTO Users (user_id, password, name) VALUES (?, ?, ?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, userId);
        pstmt.setString(2, password);  // 실제 서비스에서는 반드시 암호화해야 함
        pstmt.setString(3, name);
        
        int result = pstmt.executeUpdate();
        
        if(result > 0) {
            // 회원가입 성공
            response.sendRedirect("main.jsp?signup=success");
        } else {
            // 회원가입 실패
            response.sendRedirect("main.jsp?error=database");
        }
        
    } catch(Exception e) {
        // 오류 발생
        e.printStackTrace();
        response.sendRedirect("main.jsp?error=database");
    } finally {
        DBConnection.close(rs, pstmt, conn);
    }
%> 
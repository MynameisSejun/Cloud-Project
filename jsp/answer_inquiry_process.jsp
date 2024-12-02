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
    
    int inquiryId = Integer.parseInt(request.getParameter("inquiry_id"));
    String answer = request.getParameter("answer");
    String adminId = (String)session.getAttribute("user_id");
    
    Connection conn = null;
    PreparedStatement pstmt = null;
    
    try {
        conn = DBConnection.getConnection();
        
        String sql = "UPDATE Inquiries SET status = 'COMPLETED', answer = ?, admin_id = ?, answered_at = NOW() WHERE inquiry_id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, answer);
        pstmt.setString(2, adminId);
        pstmt.setInt(3, inquiryId);
        
        pstmt.executeUpdate();
        response.sendRedirect("admin_inquiries.jsp?answer=success");
        
    } catch(Exception e) {
        e.printStackTrace();
        response.sendRedirect("admin_inquiries.jsp?error=database");
    } finally {
        DBConnection.close(pstmt, conn);
    }
%> 
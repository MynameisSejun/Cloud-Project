<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="util.DBConnection" %>
<%
    // 관리자 권한 체크
    if(session.getAttribute("role") == null || !"ADMIN".equals(session.getAttribute("role"))) {
        response.sendRedirect("main.jsp");
        return;
    }

    // 인코딩 설정
    request.setCharacterEncoding("UTF-8");
    
    // 폼 데이터 받기
    String title = request.getParameter("title");
    String description = request.getParameter("description");
    String content = request.getParameter("content");
    int typeId = Integer.parseInt(request.getParameter("type_id"));
    String writerId = (String)session.getAttribute("user_id");
    
    Connection conn = null;
    PreparedStatement pstmt = null;
    String sql = "";
    
    try {
        conn = DBConnection.getConnection();
        
        if("edit".equals(request.getParameter("mode"))) {
            // 수정 처리
            int faqId = Integer.parseInt(request.getParameter("faq_id"));
            sql = "UPDATE Faqs SET type_id=?, title=?, description=?, content=? WHERE faq_id=?";
            pstmt = conn.prepareStatement(sql);
            
            pstmt.setInt(1, typeId);
            pstmt.setString(2, title);
            pstmt.setString(3, description);
            pstmt.setString(4, content);
            pstmt.setInt(5, faqId);
            
            pstmt.executeUpdate();
            response.sendRedirect("faq_detail.jsp?id=" + faqId + "&updated=true");
            
        } else {
            // 새 글 등록 처리
            sql = "INSERT INTO Faqs (type_id, title, description, content, writer_id, created_at) VALUES (?, ?, ?, ?, ?, NOW())";
            pstmt = conn.prepareStatement(sql);
            
            pstmt.setInt(1, typeId);
            pstmt.setString(2, title);
            pstmt.setString(3, description);
            pstmt.setString(4, content);
            pstmt.setString(5, writerId);
            
            pstmt.executeUpdate();
            response.sendRedirect("faq.jsp?write=success");
        }
        
    } catch(Exception e) {
        e.printStackTrace();
        if("edit".equals(request.getParameter("mode"))) {
            response.sendRedirect("faq_detail.jsp?id=" + request.getParameter("faq_id") + "&error=true");
        } else {
            response.sendRedirect("write_faq.jsp?error=database");
        }
    } finally {
        DBConnection.close(pstmt, conn);
    }
%> 
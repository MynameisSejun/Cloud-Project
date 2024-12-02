<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    // 로그인 체크
    if(session.getAttribute("user_id") == null) {
        response.sendRedirect("main.jsp?error=login");
        return;
    }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>1:1 문의하기 - 러닝 코스 커뮤니티 앱</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/styles/write_inquiry.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/styles/nav.css">
</head>
<body>
    <jsp:include page="nav.jsp" />
    
    <div class="write-container">
        <h2>1:1 문의하기</h2>
        <form action="write_inquiry_process.jsp" method="post" class="write-form">
            <div class="form-group">
                <label for="type_id">문의 유형</label>
                <select id="type_id" name="type_id" required>
                    <%
                        // DB 연결 정보
                        String jdbcUrl = "jdbc:mysql://localhost:3306/runningApp?serverTimezone=UTC";
                        String dbUser = "root";
                        String dbPassword = "1234";

                        Connection conn = null;
                        PreparedStatement pstmt = null;
                        ResultSet rs = null;

                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);
                            
                            String sql = "SELECT type_id, type_name FROM InquiryTypes ORDER BY type_id";
                            pstmt = conn.prepareStatement(sql);
                            rs = pstmt.executeQuery();
                            
                            while(rs.next()) {
                    %>
                                <option value="<%=rs.getInt("type_id")%>"><%=rs.getString("type_name")%></option>
                    <%
                            }
                        } catch(Exception e) {
                            e.printStackTrace();
                        } finally {
                            if(rs != null) try { rs.close(); } catch(Exception e) {}
                            if(pstmt != null) try { pstmt.close(); } catch(Exception e) {}
                            if(conn != null) try { conn.close(); } catch(Exception e) {}
                        }
                    %>
                </select>
            </div>
            
            <div class="form-group">
                <label for="title">제목</label>
                <input type="text" id="title" name="title" required 
                       placeholder="문의하실 내용을 간단히 요약해주세요">
            </div>
            
            <div class="form-group">
                <label for="content">문의 내용</label>
                <textarea id="content" name="content" rows="10" required
                          placeholder="문의하실 내용을 자세히 적어주세요"></textarea>
            </div>
            
            <div class="button-group">
                <button type="submit" class="btn btn-primary">문의하기</button>
                <button type="button" class="btn btn-cancel" onclick="location.href='inquiry.jsp'">취소</button>
            </div>
        </form>
    </div>
</body>
</html> 
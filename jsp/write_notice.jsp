<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    // 관리자 권한 체크
    if(session.getAttribute("role") == null || !"ADMIN".equals(session.getAttribute("role"))) {
        response.sendRedirect("main.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공지사항 작성 - 러닝 코스 커뮤니티 앱</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/styles/nav.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/styles/write_notice.css">
</head>
<body>
    <jsp:include page="nav.jsp" />
    
    <div class="write-container">
        <h2>공지사항 작성</h2>
        <form action="write_notice_process.jsp" method="post" class="write-form">
            <div class="form-group">
                <label for="type_id">공지 유형</label>
                <select id="type_id" name="type_id" required>
                    <%
                        Connection conn = null;
                        PreparedStatement pstmt = null;
                        ResultSet rs = null;
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/runningApp?serverTimezone=UTC", "root", "1234");
                            
                            String sql = "SELECT type_id, type_name FROM NoticeTypes";
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
                <input type="text" id="title" name="title" required>
            </div>
            
            <div class="form-group">
                <label for="content">내용</label>
                <textarea id="content" name="content" rows="15" required></textarea>
            </div>
            
            <div class="button-group">
                <button type="submit" class="btn btn-primary">등록하기</button>
                <button type="button" class="btn btn-cancel" onclick="location.href='notice.jsp'">취소</button>
            </div>
        </form>
    </div>
</body>
</html> 
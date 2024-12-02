<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FAQ - 러닝 코스 커뮤니티 앱</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/styles/faq.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/styles/nav.css">
</head>
<body>
    <jsp:include page="nav.jsp" />

    <div class="faq-container">
        <div class="faq-header">
            <h1>자주 묻는 질문 (FAQ)</h1>
            <p>앱 사용 중 궁금한 점들을 확인하세요.</p>
        </div>

        <div class="faq-list">
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
                    
                    // FAQ 목록 조회 쿼리
                    String sql = "SELECT f.*, t.type_name " +
                               "FROM Faqs f " +
                               "JOIN FaqTypes t ON f.type_id = t.type_id " +
                               "ORDER BY f.faq_id DESC";
                               
                    pstmt = conn.prepareStatement(sql);
                    rs = pstmt.executeQuery();

                    while(rs.next()) {
            %>
                        <a href="faq_detail.jsp?id=<%=rs.getInt("faq_id")%>" class="faq-item">
                            <div class="faq-info">
                                <span class="faq-badge"><%=rs.getString("type_name")%></span>
                            </div>
                            <h3><%=rs.getString("title")%></h3>
                            <p><%=rs.getString("description")%></p>
                        </a>
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
        </div>

    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const urlParams = new URLSearchParams(window.location.search);
            if(urlParams.get('deleted') === 'true') {
                alert('FAQ가 삭제되었습니다.');
            }
        });
    </script>
</body>
</html> 
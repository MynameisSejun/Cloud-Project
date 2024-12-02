<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="util.DBConnection" %>
<%
    // 현재 페이지 번호 가져오기
    int currentPage = 1;
    int itemsPerPage = 5; // 페이지당 공지사항 수
    int totalItems = 0;   // 전체 공지사항 수
    int totalPages = 0;   // 전체 페이지 수

    try {
        String pageStr = request.getParameter("page");
        if(pageStr != null) {
            currentPage = Integer.parseInt(pageStr);
        }
    } catch(NumberFormatException e) {
        currentPage = 1;
    }

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공지사항 - 러닝 코스 커뮤니티 앱</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/styles/notice.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/styles/nav.css">
</head>
<body>
    <jsp:include page="nav.jsp" />

    <div class="notice-container">
        <div class="notice-header">
            <h1>공지사항</h1>
            <p>러닝 코스 커뮤니티의 새로운 소식과 업데이트 내용을 확인하세요.</p>
        </div>

        <div class="notice-list">
        <%
            try {
                conn = DBConnection.getConnection();
                
                // 전체 게시물 수 조회
                String countQuery = "SELECT COUNT(*) FROM Notices";
                pstmt = conn.prepareStatement(countQuery);
                rs = pstmt.executeQuery();
                if(rs.next()) {
                    totalItems = rs.getInt(1);
                    totalPages = (int) Math.ceil((double) totalItems / itemsPerPage);
                }
                
                // 공지사항 목록 조회
                String query = "SELECT n.*, t.type_name, u.name as writer_name " +
                             "FROM Notices n " +
                             "JOIN NoticeTypes t ON n.type_id = t.type_id " +
                             "JOIN Users u ON n.user_id = u.user_id " +
                             "ORDER BY n.created_at DESC " +
                             "LIMIT ? OFFSET ?";
                             
                pstmt = conn.prepareStatement(query);
                pstmt.setInt(1, itemsPerPage);
                pstmt.setInt(2, (currentPage - 1) * itemsPerPage);
                rs = pstmt.executeQuery();

                while(rs.next()) {
        %>
                    <a href="notice_detail.jsp?id=<%=rs.getInt("notice_id")%>" class="notice-item">
                        <div class="notice-info">
                            <span class="notice-badge <%=rs.getString("type_name")%>">
                                <%=rs.getString("type_name")%>
                            </span>
                            <span class="notice-writer"><%=rs.getString("writer_name")%></span>
                            <span class="notice-date">
                                <%=rs.getTimestamp("created_at").toString().substring(0, 10)%>
                            </span>
                        </div>
                        <h3><%=rs.getString("title")%></h3>
                        <p><%=rs.getString("content").length() > 100 ? 
                            rs.getString("content").substring(0, 100) + "..." : 
                            rs.getString("content")%></p>
                    </a>
        <%
                }
            } catch(Exception e) {
                e.printStackTrace();
            } finally {
                DBConnection.close(rs, pstmt, conn);
            }
        %>
        </div>

        <div class="pagination">
            <button class="page-btn" onclick="changePage(<%=currentPage-1%>)" 
                    <%=currentPage <= 1 ? "disabled" : ""%>>&lt;</button>
            <% for(int i=1; i<=totalPages; i++) { %>
                <button class="page-btn <%= (i == currentPage) ? "active" : "" %>" 
                        onclick="changePage(<%=i%>)"><%=i%></button>
            <% } %>
            <button class="page-btn" onclick="changePage(<%=currentPage+1%>)"
                    <%=currentPage >= totalPages ? "disabled" : ""%>>&gt;</button>
        </div>
    </div>

    <script>
        function changePage(page) {
            if (page < 1 || page > <%=totalPages%>) return;
            window.location.href = 'notice.jsp?page=' + page;
        }

        document.addEventListener('DOMContentLoaded', function() {
            const urlParams = new URLSearchParams(window.location.search);
            if(urlParams.get('deleted') === 'true') {
                alert('공지사항이 삭제되었습니다.');
            }
        });
    </script>
</body>
</html> 
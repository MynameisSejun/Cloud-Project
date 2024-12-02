<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="util.DBConnection" %>
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
    <title>문의사항 관리 - 러닝 코스 커뮤니티 앱</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/styles/admin_inquiries.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/styles/nav.css">
</head>
<body>
    <jsp:include page="nav.jsp" />
    
    <div class="admin-container">
        <div class="admin-header">
            <h2>문의사항 관리</h2>
            <%
                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;
                
                try {
                    conn = DBConnection.getConnection();
                    
                    // 답변 대기 중인 문의 개수 조회
                    String countSql = "SELECT COUNT(*) FROM Inquiries WHERE status = 'PENDING'";
                    pstmt = conn.prepareStatement(countSql);
                    rs = pstmt.executeQuery();
                    int pendingCount = 0;
                    if(rs.next()) {
                        pendingCount = rs.getInt(1);
                    }
            %>
                    <p class="pending-count">답변 대기 중인 문의: <span><%= pendingCount %>건</span></p>
            <%
                    rs.close();
                    pstmt.close();
                    
                    // 문의사항 목록 조회
                    String sql = "SELECT i.*, t.type_name, u.name as user_name " +
                               "FROM Inquiries i " +
                               "JOIN InquiryTypes t ON i.type_id = t.type_id " +
                               "JOIN Users u ON i.user_id = u.user_id " +
                               "ORDER BY CASE WHEN i.status = 'PENDING' THEN 0 ELSE 1 END, " +
                               "i.created_at DESC";
                               
                    pstmt = conn.prepareStatement(sql);
                    rs = pstmt.executeQuery();
                    
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm");
            %>
                    <div class="filter-section">
                        <select id="statusFilter" onchange="filterInquiries()">
                            <option value="all">전체 보기</option>
                            <option value="PENDING" selected>답변 대기</option>
                            <option value="COMPLETED">답변 완료</option>
                        </select>
                    </div>

                    <div class="inquiry-list">
            <%
                    while(rs.next()) {
                        String status = rs.getString("status");
                        String statusClass = "COMPLETED".equals(status) ? "completed" : "pending";
            %>
                        <div class="inquiry-item <%= statusClass %>" data-status="<%= status %>">
                            <div class="inquiry-header">
                                <span class="inquiry-type"><%= rs.getString("type_name") %></span>
                                <span class="inquiry-date"><%= sdf.format(rs.getTimestamp("created_at")) %></span>
                                <span class="inquiry-status <%= statusClass %>">
                                    <%= "COMPLETED".equals(status) ? "답변 완료" : "답변 대기" %>
                                </span>
                            </div>
                            <div class="inquiry-content">
                                <h3><%= rs.getString("title") %></h3>
                                <p class="inquiry-writer">작성자: <%= rs.getString("user_name") %></p>
                                <p class="inquiry-text"><%= rs.getString("content") %></p>
                            </div>
                            <% if("COMPLETED".equals(status)) { %>
                                <div class="answer-section">
                                    <p class="answer-date">답변일: <%= sdf.format(rs.getTimestamp("answered_at")) %></p>
                                    <p class="answer-text"><%= rs.getString("answer") %></p>
                                </div>
                            <% } else { %>
                                <div class="answer-form">
                                    <form action="answer_inquiry_process.jsp" method="post">
                                        <input type="hidden" name="inquiry_id" value="<%= rs.getInt("inquiry_id") %>">
                                        <textarea name="answer" required placeholder="답변을 입력하세요"></textarea>
                                        <button type="submit" class="btn-answer">답변 등록</button>
                                    </form>
                                </div>
                            <% } %>
                        </div>
            <%
                    }
            %>
                    </div>
            <%
                } catch(Exception e) {
                    e.printStackTrace();
                } finally {
                    DBConnection.close(rs, pstmt, conn);
                }
            %>
        </div>
    </div>

    <script>
        function filterInquiries() {
            const status = document.getElementById('statusFilter').value;
            const items = document.querySelectorAll('.inquiry-item');
            
            items.forEach(item => {
                if(status === 'all' || item.dataset.status === status) {
                    item.style.display = 'block';
                } else {
                    item.style.display = 'none';
                }
            });
        }

        // 페이지 로드 시 기본적으로 답변 대기 중인 문의만 표시
        document.addEventListener('DOMContentLoaded', function() {
            filterInquiries();
        });
    </script>
</body>
</html> 
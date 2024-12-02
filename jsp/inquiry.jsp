<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.sql.*" %>
<%@ page import="util.DBConnection" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>1:1 문의 내역 - 러닝 코스 커뮤니티 앱</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/styles/inquiry.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/styles/nav.css">
</head>
<body>
    <jsp:include page="nav.jsp" />

    <div class="inquiry-container">
        <div class="inquiry-header">
            <h1>1:1 문의 내역</h1>
            <p>1:1 문의 사항을 확인하고, 빠르게 답변을 받을 수 있습니다.</p>
            <hr class="divider">
        </div>

        <div class="inquiry-list">
            <%
                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;

                try {
                    conn = DBConnection.getConnection();
                    
                    String sql = "SELECT * FROM Inquiries WHERE user_id = ? ORDER BY created_at DESC";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, (String)session.getAttribute("user_id"));
                    
                    rs = pstmt.executeQuery();

                    while(rs.next()) {
            %>
                        <div class="inquiry-item">
                            <a href="inquiry_detail.jsp?id=<%= rs.getInt("inquiry_id") %>" class="inquiry-link">
                                <div class="inquiry-info">
                                    <span class="inquiry-status <%= rs.getString("status").equals("COMPLETED") ? "completed" : "in-progress" %>">
                                        <%= rs.getString("status").equals("COMPLETED") ? "답변 완료" : "진행 중" %>
                                    </span>
                                    <span class="inquiry-date">
                                        <%= new SimpleDateFormat("yyyy.MM.dd").format(rs.getTimestamp("created_at")) %>
                                    </span>
                                </div>
                                <h3><%= rs.getString("title") %></h3>
                                <p><%= rs.getString("content") %></p>
                            </a>
                            <button class="delete-btn" data-inquiry-id="<%= rs.getInt("inquiry_id") %>">삭제</button>
                        </div>
            <%
                    }
                } catch(Exception e) {
                    e.printStackTrace();
                } finally {
                    DBConnection.close(rs, pstmt, conn);
                }
            %>
        </div>

        <div class="inquiry-btn-container">
            <a href="write_inquiry.jsp" class="inquiry-btn">1:1 문의 하기</a>
        </div>
    </div>
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // URL 파라미터 체크
            const urlParams = new URLSearchParams(window.location.search);
            if(urlParams.get('deleted') === 'true') {
                alert('문의사항이 삭제되었습니다.');
            }

            // 삭제 버튼 이벤트
            document.querySelector('.inquiry-list').addEventListener('click', function(e) {
                if (e.target.classList.contains('delete-btn')) {
                    e.preventDefault();
                    const inquiryId = e.target.dataset.inquiryId;
                    if (confirm("이 문의를 삭제하시겠습니까?")) {
                        const form = document.createElement('form');
                        form.method = 'POST';
                        form.action = 'inquiry_detail.jsp?id=' + inquiryId;
                        
                        const actionInput = document.createElement('input');
                        actionInput.type = 'hidden';
                        actionInput.name = 'action';
                        actionInput.value = 'delete';
                        
                        form.appendChild(actionInput);
                        document.body.appendChild(form);
                        form.submit();
                    }
                }
            });
        });
    </script>
</body>
</html> 
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="util.DBConnection" %>
<%
    // 로그인 체크
    if(session.getAttribute("user_id") == null) {
        response.sendRedirect("main.jsp?error=login");
        return;
    }

    request.setCharacterEncoding("UTF-8");

    // POST 요청 처리 (삭제)
    if ("POST".equalsIgnoreCase(request.getMethod()) && "delete".equals(request.getParameter("action"))) {
        int inquiryId = Integer.parseInt(request.getParameter("id"));
        String userId = (String)session.getAttribute("user_id");
        
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = DBConnection.getConnection();
            String sql = "DELETE FROM Inquiries WHERE inquiry_id = ? AND user_id = ? AND status != 'COMPLETED'";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, inquiryId);
            pstmt.setString(2, userId);
            
            int result = pstmt.executeUpdate();
            if(result > 0) {
                response.sendRedirect("inquiry.jsp?deleted=true");
                return;
            }
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            DBConnection.close(pstmt, conn);
        }
    }

    // 문의사항 ID 가져오기
    int inquiryId = Integer.parseInt(request.getParameter("id"));
    String userId = (String)session.getAttribute("user_id");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>문의사항 상세 - 러닝 코스 커뮤니티 앱</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/styles/inquiry_detail.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/styles/nav.css">
</head>
<body>
    <jsp:include page="nav.jsp" />
    
    <div class="detail-container">
        <%
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            try {
                conn = DBConnection.getConnection();
                
                // 문의사항 상세 정보 조회
                String sql = "SELECT i.*, t.type_name, u.name as user_name, a.name as admin_name " +
                           "FROM Inquiries i " +
                           "JOIN InquiryTypes t ON i.type_id = t.type_id " +
                           "JOIN Users u ON i.user_id = u.user_id " +
                           "LEFT JOIN Users a ON i.admin_id = a.user_id " +
                           "WHERE i.inquiry_id = ? AND i.user_id = ?";
                           
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, inquiryId);
                pstmt.setString(2, userId);
                rs = pstmt.executeQuery();

                if(rs.next()) {
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm");
                    String status = rs.getString("status");
        %>
                    <div class="detail-header">
                        <h2>문의사항 상세</h2>
                        <span class="inquiry-status <%= "COMPLETED".equals(status) ? "completed" : "pending" %>">
                            <%= "COMPLETED".equals(status) ? "답변 완료" : "답변 대기" %>
                        </span>
                    </div>

                    <div class="inquiry-section">
                        <div class="inquiry-info">
                            <span class="inquiry-type"><%= rs.getString("type_name") %></span>
                            <span class="inquiry-date">작성일: <%= sdf.format(rs.getTimestamp("created_at")) %></span>
                        </div>
                        <h3 class="inquiry-title"><%= rs.getString("title") %></h3>
                        <div class="inquiry-content">
                            <%= rs.getString("content").replace("\n", "<br>") %>
                        </div>
                    </div>

                    <% if("COMPLETED".equals(status)) { %>
                        <div class="answer-section">
                            <div class="answer-header">
                                <h3>답변</h3>
                                <div class="answer-info">
                                    <span class="admin-name">답변자: <%= rs.getString("admin_name") %></span>
                                    <span class="answer-date">답변일: <%= sdf.format(rs.getTimestamp("answered_at")) %></span>
                                </div>
                            </div>
                            <div class="answer-content">
                                <%= rs.getString("answer").replace("\n", "<br>") %>
                            </div>
                        </div>
                    <% } %>

                    <div class="button-group">
                        <button onclick="location.href='inquiry.jsp'" class="btn btn-back">목록으로</button>
                        <% if(!"COMPLETED".equals(status)) { %>
                            <button onclick="deleteInquiry()" class="btn btn-delete">삭제</button>
                        <% } %>
                    </div>
        <%
                } else {
        %>
                    <div class="error-message">
                        <p>해당 문의사항을 찾을 수 없거나 접근 권한이 없습니다.</p>
                        <button onclick="location.href='inquiry.jsp'" class="btn btn-back">목록으로</button>
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

    <script>
        function deleteInquiry() {
            if(confirm('정말로 이 문의를 삭제하시겠습니까?')) {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = 'inquiry_detail.jsp?id=<%=inquiryId%>';
                
                const actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'delete';
                
                form.appendChild(actionInput);
                document.body.appendChild(form);
                form.submit();
            }
        }
    </script>

    <% if("true".equals(request.getParameter("deleted"))) { %>
        <script>
            alert('문의사항이 성공적으로 삭제되었습니다.');
        </script>
    <% } %>
</body>
</html> 
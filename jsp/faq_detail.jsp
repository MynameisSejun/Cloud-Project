<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="util.DBConnection" %>

<%
    // POST 요청 처리 (삭제)
    if ("POST".equalsIgnoreCase(request.getMethod()) && "delete".equals(request.getParameter("action"))) {
        if ("ADMIN".equals(session.getAttribute("role"))) {
            int faqId = Integer.parseInt(request.getParameter("id"));
            Connection conn = null;
            PreparedStatement pstmt = null;
            
            try {
                conn = DBConnection.getConnection();
                String sql = "DELETE FROM Faqs WHERE faq_id = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, faqId);
                
                int result = pstmt.executeUpdate();
                if(result > 0) {
                    response.sendRedirect("faq.jsp?deleted=true");
                    return;
                }
            } catch(Exception e) {
                e.printStackTrace();
            } finally {
                DBConnection.close(pstmt, conn);
            }
        }
    }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FAQ 상세 - 러닝 코스 커뮤니티 앱</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/styles/faq.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/styles/nav.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/styles/write_faq.css">
</head>
<body>
    <jsp:include page="nav.jsp" />

    <div class="faq-container">
        <%
            int faqId = Integer.parseInt(request.getParameter("id"));
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            try {
                conn = DBConnection.getConnection();
                String sql = "SELECT f.*, t.type_name, u.name as writer_name " +
                           "FROM Faqs f " +
                           "JOIN FaqTypes t ON f.type_id = t.type_id " +
                           "JOIN Users u ON f.writer_id = u.user_id " +
                           "WHERE f.faq_id = ?";
                           
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, faqId);
                rs = pstmt.executeQuery();

                if(rs.next()) {
                    if("edit".equals(request.getParameter("mode"))) {
        %>
                        <div class="write-container">
                            <h2>FAQ 수정</h2>
                            <form action="write_faq_process.jsp" method="post" class="write-form" accept-charset="UTF-8">
                                <input type="hidden" name="faq_id" value="<%=faqId%>">
                                <input type="hidden" name="mode" value="edit">
                                
                                <div class="form-group">
                                    <label for="type_id">FAQ 유형</label>
                                    <select id="type_id" name="type_id" required>
                                        <%
                                            PreparedStatement typeStmt = null;
                                            ResultSet typeRs = null;
                                            try {
                                                String typeSql = "SELECT type_id, type_name FROM FaqTypes";
                                                typeStmt = conn.prepareStatement(typeSql);
                                                typeRs = typeStmt.executeQuery();
                                                while(typeRs.next()) {
                                                    boolean selected = typeRs.getInt("type_id") == rs.getInt("type_id");
                                        %>
                                                    <option value="<%=typeRs.getInt("type_id")%>" <%=selected ? "selected" : ""%>>
                                                        <%=typeRs.getString("type_name")%>
                                                    </option>
                                        <%
                                                }
                                            } finally {
                                                if(typeRs != null) typeRs.close();
                                                if(typeStmt != null) typeStmt.close();
                                            }
                                        %>
                                    </select>
                                </div>
                                
                                <div class="form-group">
                                    <label for="title">제목</label>
                                    <input type="text" id="title" name="title" value="<%=rs.getString("title")%>" required>
                                </div>
                                
                                <div class="form-group">
                                    <label for="description">간단 설명</label>
                                    <input type="text" id="description" name="description" value="<%=rs.getString("description")%>" required>
                                    <small class="form-text">FAQ 목록에서 보여질 간단한 설명을 입력하세요.</small>
                                </div>
                                
                                <div class="form-group">
                                    <label for="content">상세 내용</label>
                                    <textarea id="content" name="content" rows="15" required><%=rs.getString("content")%></textarea>
                                </div>
                                
                                <div class="button-group">
                                    <button type="submit" class="btn btn-primary">수정 완료</button>
                                    <button type="button" class="btn btn-cancel" onclick="location.href='faq_detail.jsp?id=<%=faqId%>'">취소</button>
                                </div>
                            </form>
                        </div>
        <%
                    } else {
        %>
                        <div class="faq-header">
                            <h1><%=rs.getString("title")%></h1>
                            <p><%=rs.getString("description")%></p>
                        </div>

                        <hr class="separator">

                        <div class="faq-detail-content">
                            <%=rs.getString("content").replace("\n", "<br>")%>
                        </div>
                        
                        <div class="faq-detail-footer">
                            <button onclick="location.href='faq.jsp'" class="btn-back">목록으로</button>
                            <% if("ADMIN".equals(session.getAttribute("role"))) { %>
                                <button onclick="location.href='faq_detail.jsp?id=<%=faqId%>&mode=edit'" class="btn-back">수정</button>
                                <button onclick="deleteFaq()" class="btn-back delete-btn">삭제</button>
                            <% } %>
                        </div>
        <%
                    }
                }
            } catch(Exception e) {
                e.printStackTrace();
            } finally {
                DBConnection.close(rs, pstmt, conn);
            }
        %>
    </div>

    <script>
    function deleteFaq() {
        if(confirm('이 FAQ를 삭제하시겠습니까?')) {
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = 'faq_detail.jsp?id=<%=faqId%>';
            
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
</body>
</html> 
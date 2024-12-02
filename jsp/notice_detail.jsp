<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="util.DBConnection" %>
<%
    request.setCharacterEncoding("UTF-8");

    // POST 요청 처리 (수정)
    if ("POST".equalsIgnoreCase(request.getMethod()) && "edit".equals(request.getParameter("action"))) {
        if ("ADMIN".equals(session.getAttribute("role"))) {
            int noticeId = Integer.parseInt(request.getParameter("notice_id"));
            String title = request.getParameter("title");
            String content = request.getParameter("content");
            int typeId = Integer.parseInt(request.getParameter("type_id"));
            
            Connection conn = null;
            PreparedStatement pstmt = null;
            
            try {
                conn = DBConnection.getConnection();
                String sql = "UPDATE Notices SET type_id=?, title=?, content=? WHERE notice_id=?";
                pstmt = conn.prepareStatement(sql);
                
                pstmt.setInt(1, typeId);
                pstmt.setString(2, title);
                pstmt.setString(3, content);
                pstmt.setInt(4, noticeId);
                
                int result = pstmt.executeUpdate();
                if(result > 0) {
                    response.sendRedirect("notice_detail.jsp?id=" + noticeId + "&updated=true");
                    return;
                }
            } catch(Exception e) {
                e.printStackTrace();
            } finally {
                DBConnection.close(pstmt, conn);
            }
        }
    }

    // POST 요청 처리 (삭제)
    if ("POST".equalsIgnoreCase(request.getMethod()) && "delete".equals(request.getParameter("action"))) {
        if ("ADMIN".equals(session.getAttribute("role"))) {
            int noticeId = Integer.parseInt(request.getParameter("id"));
            Connection conn = null;
            PreparedStatement pstmt = null;
            
            try {
                conn = DBConnection.getConnection();
                String sql = "DELETE FROM Notices WHERE notice_id = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, noticeId);
                
                int result = pstmt.executeUpdate();
                if(result > 0) {
                    response.sendRedirect("notice.jsp?deleted=true");
                    return;
                }
            } catch(Exception e) {
                e.printStackTrace();
            } finally {
                DBConnection.close(pstmt, conn);
            }
        }
    }

    int noticeId = Integer.parseInt(request.getParameter("id"));
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공지사항 상세 - 러닝 코스 커뮤니티 앱</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/styles/notice.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/styles/nav.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/styles/write_notice.css">
</head>
<body>
    <jsp:include page="nav.jsp" />
    
    <div class="notice-container">
        <%
            try {
                conn = DBConnection.getConnection();
                String sql = "SELECT n.*, t.type_name, u.name as writer_name " +
                           "FROM Notices n " +
                           "JOIN NoticeTypes t ON n.type_id = t.type_id " +
                           "JOIN Users u ON n.user_id = u.user_id " +
                           "WHERE n.notice_id = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, noticeId);
                rs = pstmt.executeQuery();

                if(rs.next()) {
                    if("edit".equals(request.getParameter("mode")) && "ADMIN".equals(session.getAttribute("role"))) {
        %>
                        <div class="write-container">
                            <h2>공지사항 수정</h2>
                            <form method="post" class="write-form" accept-charset="UTF-8">
                                <input type="hidden" name="action" value="edit">
                                <input type="hidden" name="notice_id" value="<%=noticeId%>">
                                
                                <div class="form-group">
                                    <label for="type_id">공지 유형</label>
                                    <select id="type_id" name="type_id" required>
                                        <%
                                            PreparedStatement typeStmt = null;
                                            ResultSet typeRs = null;
                                            try {
                                                String typeSql = "SELECT type_id, type_name FROM NoticeTypes";
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
                                    <label for="content">내용</label>
                                    <textarea id="content" name="content" rows="15" required><%=rs.getString("content")%></textarea>
                                </div>
                                
                                <div class="button-group">
                                    <button type="submit" class="btn btn-primary">수정 완료</button>
                                    <button type="button" class="btn btn-cancel" onclick="location.href='notice_detail.jsp?id=<%=noticeId%>'">취소</button>
                                </div>
                            </form>
                        </div>
        <%
                    } else {
                        // 이전/다음 공지사항 ID 조회
                        String navQuery = "SELECT " +
                            "(SELECT notice_id FROM Notices WHERE notice_id < ? ORDER BY notice_id DESC LIMIT 1) as prev_id, " +
                            "(SELECT notice_id FROM Notices WHERE notice_id > ? ORDER BY notice_id ASC LIMIT 1) as next_id";
                        pstmt = conn.prepareStatement(navQuery);
                        pstmt.setInt(1, noticeId);
                        pstmt.setInt(2, noticeId);
                        ResultSet navRs = pstmt.executeQuery();
                        navRs.next();
                        Integer prevId = navRs.getObject("prev_id", Integer.class);
                        Integer nextId = navRs.getObject("next_id", Integer.class);
        %>
                        <div class="notice-detail">
                            <div class="notice-detail-header">
                                <div class="notice-info">
                                    <span class="notice-badge <%=rs.getString("type_name")%>">
                                        <%=rs.getString("type_name")%>
                                    </span>
                                    <span class="notice-writer"><%=rs.getString("writer_name")%></span>
                                    <span class="notice-date">
                                        <%=rs.getTimestamp("created_at").toString().substring(0, 10)%>
                                    </span>
                                </div>
                                <h2><%=rs.getString("title")%></h2>
                            </div>

                            <div class="notice-detail-content">
                                <p><%=rs.getString("content").replace("\n", "<br>")%></p>
                            </div>

                            <div class="notice-navigation">
                                <% if(prevId != null) { %>
                                    <button onclick="location.href='notice_detail.jsp?id=<%=prevId%>'" class="btn-nav">
                                        <span class="arrow">←</span> 이전 공지사항
                                    </button>
                                <% } else { %>
                                    <button class="btn-nav disabled" disabled>
                                        <span class="arrow">←</span> 이전 공지사항
                                    </button>
                                <% } %>

                                <div class="notice-actions">
                                    <button onclick="location.href='notice.jsp'" class="btn-back">목록으로</button>
                                    <% if("ADMIN".equals(session.getAttribute("role"))) { %>
                                        <button onclick="location.href='notice_detail.jsp?id=<%=noticeId%>&mode=edit'" class="btn-back">수정</button>
                                        <button onclick="deleteNotice()" class="btn-back delete-btn">삭제</button>
                                    <% } %>
                                </div>

                                <% if(nextId != null) { %>
                                    <button onclick="location.href='notice_detail.jsp?id=<%=nextId%>'" class="btn-nav">
                                        다음 공지사항 <span class="arrow">→</span>
                                    </button>
                                <% } else { %>
                                    <button class="btn-nav disabled" disabled>
                                        다음 공지사항 <span class="arrow">→</span>
                                    </button>
                                <% } %>
                            </div>
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
    function deleteNotice() {
        if(confirm('이 공지사항을 삭제하시겠습니까?')) {
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = 'notice_detail.jsp?id=<%=noticeId%>';
            
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

    <% if("true".equals(request.getParameter("updated"))) { %>
        <script>
            alert('공지사항이 성공적으로 수정되었습니다.');
        </script>
    <% } %>
</body>
</html> 
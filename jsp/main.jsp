<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="util.DBConnection" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>러닝 코스 커뮤니티 앱</title>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/styles/main.css">
  <link rel="stylesheet" href="<%=request.getContextPath()%>/styles/nav.css">
</head>
<body>
  <jsp:include page="nav.jsp" />
  
  <header>
    <h1>러닝 코스 커뮤니티 앱<br><span>당신만의 특별한 러닝 여정을 시작하세요!</span></h1>
  </header>
  <div class="container">
    <div class="split-section">
      <div class="section-half">
        <h2>FAQ</h2>
        <div class="grid-list">
          <%
              Connection conn = null;
              PreparedStatement pstmt = null;
              ResultSet rs = null;

              try {
                  conn = DBConnection.getConnection();
                  
                  String sql = "SELECT faq_id, title, description " +
                              "FROM Faqs " +
                              "ORDER BY created_at DESC " +
                              "LIMIT 4";
                              
                  pstmt = conn.prepareStatement(sql);
                  rs = pstmt.executeQuery();

                  while(rs.next()) {
          %>
                      <a href="faq_detail.jsp?id=<%=rs.getInt("faq_id")%>" class="grid-item">
                          <h3>Q. <%=rs.getString("title")%></h3>
                          <p><%=rs.getString("description")%></p>
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
      </div>
      <div class="section-half">
        <h2>추천 코스</h2>
        <div class="grid-list">
          <a href="course_hangang.jsp" class="grid-item">
            <div class="map-image">
              <img src="../images/hangang.png" alt="한강 러닝 코스 지도">
            </div>
            <div class="course-info">
              <h3>한강 러닝 코스</h3>
              <p>난이도: ★★☆☆☆ | 거리: 5km</p>
            </div>
          </a>
          <a href="course_olympic.jsp" class="grid-item">
            <div class="map-image">
              <img src="../images/olympic.jpg" alt="올림픽 공원 코스 지도">
            </div>
            <div class="course-info">
              <h3>올림픽 공원 코스</h3>
              <p>난이도: ★★★☆☆ | 거리: 7km</p>
            </div>
          </a>
          <a href="course_namsan.jsp" class="grid-item">
            <div class="map-image">
              <img src="../images/namsan.png" alt="남산 순환 코스 지도">
            </div>
            <div class="course-info">
              <h3>남산 순환 코스</h3>
              <p>난이도: ★★★★☆ | 거리: 8km</p>
            </div>
          </a>
          <a href="course_bukhansan.jsp" class="grid-item">
            <div class="map-image">
              <img src="../images/bukhansan.jpg" alt="북한산 트레일 지도">
            </div>
            <div class="course-info">
              <h3>북한산 트레일</h3>
              <p>난이도: ★★★★★ | 거리: 12km</p>
            </div>
          </a>
        </div>
      </div>
    </div>
  </div>
  <footer>
    <p>&copy; 2024 러닝 코스 커뮤니티 앱. All Rights Reserved.</p>
  </footer>
</body>
</html> 
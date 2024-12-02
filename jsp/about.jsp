<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>앱 설명 - 러닝 코스 커뮤니티 앱</title>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/styles/about.css">
  <link rel="stylesheet" href="<%=request.getContextPath()%>/styles/nav.css">
</head>
<body>
  <!-- 네비게이션 바 include -->
  <jsp:include page="nav.jsp" />

  <div class="app-description">
    <div class="app-logo-section">
      <img src="../images/just_run.png" alt="러닝 코스 앱 로고">
      <p>러닝 코스 커뮤니티 앱은 러너들의 즐거운 러닝 경험을 위해 태어났습니다. <br>
         혼자서도, 함께서도 즐겁게 달릴 수 있는 환경을 제공하며,
         당신의 모든 러닝 순간을 특별하게 만들어드립니다.</p>
    </div>

    <div class="feature-banner" style="background-image: url('../images/course_create.jpg')">
      <div class="feature-banner-content">
        <h3>나만의 코스 생성</h3>
        <p>원하는 경로를 직접 설계하고 저장하세요. 거리, 고도, 난이도 등 상세한 정보와 함께 <br>
           나만의 특별한 러닝 코스를 만들 수 있습니다. 직접 뛰어본 코스를 바탕으로 <br>
           더 정확한 정보를 기록할 수 있습니다.</p>
      </div>
    </div>

    <div class="feature-banner" style="background-image: url('../images/running-share.jpg')">
      <div class="feature-banner-content" style="text-align: right;">
        <h3>코스 공유하기</h3>
        <p>나만 알고 있기 아까운 좋은 코스가 있나요? 다른 러너들과 함께 공유해보세요. <br>
           코스에 대한 리뷰와 평가를 주고받으며 더 좋은 러닝 경험을 만들어갈 수 있습니다. <br>
           다른 러너들의 추천 코스도 살펴보세요.</p>
      </div>
    </div>

    <div class="feature-banner" style="background-image: url('../images/running-record.jpg')">
      <div class="feature-banner-content">
        <h3>러닝 기록 측정</h3>
        <p>GPS 기반의 정확한 거리 측정과 함께 페이스, 속도, 고도 변화까지 상세하게 기록됩니다. <br>
           실시간으로 현재 상태를 확인하고, 러닝이 끝난 후에는 상세한 분석 데이터를 <br>
           확인할 수 있습니다.</p>
      </div>
    </div>

    <div class="description-section">
      <h2>주요 기능</h2>
      <div class="feature-grid">
        <div class="feature-card">
          <div class="feature-icon">🎯</div>
          <h3>목표 설정</h3>
          <p>개인별 맞춤 목표를 설정하고 달성해나가며 성장할 수 있습니다.</p>
        </div>
        <div class="feature-card">
          <div class="feature-icon">📊</div>
          <h3>상세 통계</h3>
          <p>러닝 기록을 다양한 통계와 그래프로 한눈에 확인할 수 있습니다.</p>
        </div>
        <div class="feature-card">
          <div class="feature-icon">👥</div>
          <h3>러닝 크루</h3>
          <p>같은 목표를 가진 러너들과 함께 러닝 크루를 만들어 활동할 수 있습니다.</p>
        </div>
        <div class="feature-card">
          <div class="feature-icon">🏆</div>
          <h3>도전 과제</h3>
          <p>다양한 도전 과제를 달성하며 러닝에 대한 동기부여를 얻을 수 있습니다.</p>
        </div>
      </div>
    </div>
  </div>

  <footer>
    <p>&copy; 2024 러닝 코스 커뮤니티 앱. All Rights Reserved.</p>
  </footer>
</body>
</html> 
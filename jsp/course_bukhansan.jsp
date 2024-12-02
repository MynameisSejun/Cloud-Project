<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>북한산 트레일 - 러닝 코스 커뮤니티 앱</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/styles/nav.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/styles/main.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/styles/course_detail.css">
</head>
<body>
    <jsp:include page="nav.jsp" />
    
    <div class="course-detail">
        <div class="course-header">
            <h1>북한산 트레일</h1>
            <p>도전적인 산악 러닝을 위한 12km 트레일 코스</p>
        </div>

        <div class="course-map">
            <img src="../images/bukhansan.jpg" alt="북한산 트레일 지도">
        </div>

        <div class="course-info">
            <div class="course-stats">
                <div class="stat-item">
                    <h3>거리</h3>
                    <p>12km</p>
                </div>
                <div class="stat-item">
                    <h3>난이도</h3>
                    <p>★★★★★</p>
                </div>
                <div class="stat-item">
                    <h3>예상 소요 시간</h3>
                    <p>100-120분</p>
                </div>
            </div>

            <div class="course-description">
                <h2>코스 설명</h2>
                <p>북한산의 아름다운 자연을 만끽할 수 있는 트레일 러닝 코스입니다. 가파른 오르막과 내리막이 있어 고급 러너들에게 추천됩니다. 숲길과 암벽 지대를 번갈아 달리며 다양한 지형을 경험할 수 있습니다.</p>
            </div>

            <div class="course-tips">
                <h2>러닝 팁</h2>
                <ul>
                    <li>트레일 러닝화 착용 필수</li>
                    <li>충분한 물과 에너지바 준비 필요</li>
                    <li>날씨 변화에 대비한 바람막이 준비 권장</li>
                </ul>
            </div>
        </div>
    </div>
</body>
</html> 
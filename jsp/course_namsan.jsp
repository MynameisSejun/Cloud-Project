<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>남산 순환 코스 - 러닝 코스 커뮤니티 앱</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/styles/nav.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/styles/main.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/styles/course_detail.css">
</head>
<body>
    <jsp:include page="nav.jsp" />
    
    <div class="course-detail">
        <div class="course-header">
            <h1>남산 순환 코스</h1>
            <p>서울의 중심에서 즐기는 도심 속 트레일 러닝 8km 코스</p>
        </div>

        <div class="course-map">
            <img src="../images/namsan.png" alt="남산 순환 코스 지도">
        </div>

        <div class="course-info">
            <div class="course-stats">
                <div class="stat-item">
                    <h3>거리</h3>
                    <p>8km</p>
                </div>
                <div class="stat-item">
                    <h3>난이도</h3>
                    <p>★★★★☆</p>
                </div>
                <div class="stat-item">
                    <h3>예상 소요 시간</h3>
                    <p>70-80분</p>
                </div>
            </div>

            <div class="course-description">
                <h2>코스 설명</h2>
                <p>남산 둘레를 순환하는 트레일 러닝 코스입니다. 도심 속에서 자연을 만끽할 수 있으며, 중간중간 서울의 전경을 감상할 수 있는 뷰포인트가 있습니다. 경사가 있는 구간이 많아 체력 향상에 좋습니다.</p>
            </div>

            <div class="course-tips">
                <h2>러닝 팁</h2>
                <ul>
                    <li>경사가 있는 구간이 많으니 체력 안배가 중요</li>
                    <li>야간 러닝 시 안전을 위해 헤드랜턴 필수</li>
                    <li>중간에 전망대에서 휴식하며 서울 전경 감상 추천</li>
                </ul>
            </div>
        </div>
    </div>
</body>
</html>
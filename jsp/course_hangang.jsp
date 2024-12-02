<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>한강 러닝 코스 - 러닝 코스 커뮤니티 앱</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/styles/nav.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/styles/main.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/styles/course_detail.css">
</head>
<body>
    <jsp:include page="nav.jsp" />
    
    <div class="course-detail">
        <div class="course-header">
            <h1>한강 러닝 코스</h1>
            <p>서울의 대표적인 러닝 코스, 한강변을 따라 달리는 5km 코스</p>
        </div>

        <div class="course-map">
            <img src="../images/hangang.png" alt="한강 러닝 코스 지도">
        </div>

        <div class="course-info">
            <div class="course-stats">
                <div class="stat-item">
                    <h3>거리</h3>
                    <p>5km</p>
                </div>
                <div class="stat-item">
                    <h3>난이도</h3>
                    <p>★★☆☆☆</p>
                </div>
                <div class="stat-item">
                    <h3>예상 소요 시간</h3>
                    <p>30-40분</p>
                </div>
            </div>

            <div class="course-description">
                <h2>코스 설명</h2>
                <p>한강공원을 따라 이어지는 평탄한 러닝 코스입니다. 강변을 따라 달리며 서울의 아름다운 전경을 감상할 수 있습니다.</p>
            </div>

            <div class="course-tips">
                <h2>러닝 팁</h2>
                <ul>
                    <li>이른 아침이나 저녁 시간대 추천</li>
                    <li>화장실과 편의시설이 곳곳에 위치</li>
                    <li>자전거 도로와 구분된 전용 러닝 트랙 이용</li>
                </ul>
            </div>
        </div>
    </div>
</body>
</html>

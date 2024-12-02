<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>올림픽 공원 코스 - 러닝 코스 커뮤니티 앱</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/styles/nav.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/styles/main.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/styles/course_detail.css">
</head>
<body>
    <jsp:include page="nav.jsp" />
    
    <div class="course-detail">
        <div class="course-header">
            <h1>올림픽 공원 코스</h1>
            <p>자연과 문화가 어우러진 올림픽 공원의 7km 러닝 코스</p>
        </div>

        <div class="course-map">
            <img src="../images/olympic.jpg" alt="올림픽 공원 코스 지도">
        </div>

        <div class="course-info">
            <div class="course-stats">
                <div class="stat-item">
                    <h3>거리</h3>
                    <p>7km</p>
                </div>
                <div class="stat-item">
                    <h3>난이도</h3>
                    <p>★★★☆☆</p>
                </div>
                <div class="stat-item">
                    <h3>예상 소요 시간</h3>
                    <p>50-60분</p>
                </div>
            </div>

            <div class="course-description">
                <h2>코스 설명</h2>
                <p>올림픽 공원의 아름다운 조경과 예술 작품들을 감상하며 달릴 수 있는 코스입니다. 평화의 문부터 시작하여 공원 전체를 순환하는 루트로, 중간중간 휴식과 스트레칭을 할 수 있는 공간이 잘 마련되어 있습니다.</p>
            </div>

            <div class="course-tips">
                <h2>러닝 팁</h2>
                <ul>
                    <li>주말에는 방문객이 많으니 이른 아침 러닝 추천</li>
                    <li>공원 내 음수대와 화장실이 잘 구비되어 있음</li>
                    <li>몽촌토성 구간은 경사가 있으니 체력 안배 필요</li>
                </ul>
            </div>
        </div>
    </div>
</body>
</html>
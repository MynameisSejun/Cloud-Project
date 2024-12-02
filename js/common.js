// 네비게이션 로드 및 초기화를 처리하는 공통 스크립트
function loadNavigation() {
    fetch('../nav.jsp')
        .then(response => response.text())
        .then(data => {
            document.getElementById('nav-placeholder').innerHTML = data;
            initializeLoginModal();
        });
}

document.addEventListener('DOMContentLoaded', loadNavigation); 
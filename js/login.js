document.addEventListener('DOMContentLoaded', function() {
    // 모달 요소들 가져오기
    const modal = document.getElementById('loginModal');
    const loginBtn = document.getElementById('loginButton');
    const closeBtn = document.querySelector('.modal .close');
  
    // 요소가 모두 로드되었는지 확인
    if (!modal || !loginBtn || !closeBtn) {
      console.error('로그인 모달 관련 요소를 찾을 수 없습니다.');
      return;
    }
  
    // 로그인 버튼 클릭 이벤트
    loginBtn.addEventListener('click', function() {
      modal.style.display = 'flex'; // 모달 열기
      document.body.style.overflow = 'hidden'; // 스크롤 비활성화
    });
  
    // 닫기 버튼 클릭 이벤트
    closeBtn.addEventListener('click', function() {
      modal.style.display = 'none'; // 모달 닫기
      document.body.style.overflow = 'auto'; // 스크롤 활성화
    });
  
    // 모달 외부 클릭 시 닫기
    window.addEventListener('click', function(event) {
      if (event.target === modal) {
        modal.style.display = 'none';
        document.body.style.overflow = 'auto';
      }
    });
  });
  
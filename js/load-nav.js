  // 모달 관련 이벤트를 설정하는 함수
  function setupModalEvents() {
    const modal = document.getElementById('loginModal');
    const loginBtn = document.getElementById('loginButton');
    const closeBtn = document.querySelector('.modal .close');
  
    if (!modal || !loginBtn || !closeBtn) {
      console.error('모달 관련 요소를 찾을 수 없습니다.');
      return;
    }
  
    // 로그인 버튼 클릭 이벤트
    loginBtn.addEventListener('click', () => {
      modal.style.display = 'flex'; // 모달 열기
      document.body.style.overflow = 'hidden'; // 스크롤 비활성화
    });
  
    // 닫기 버튼 클릭 이벤트
    closeBtn.addEventListener('click', () => {
      modal.style.display = 'none'; // 모달 닫기
      document.body.style.overflow = 'auto'; // 스크롤 활성화
    });
  
    // 모달 외부 클릭 시 닫기
    window.addEventListener('click', (event) => {
      if (event.target === modal) {
        modal.style.display = 'none';
        document.body.style.overflow = 'auto';
      }
    });
  }
  
  document.addEventListener('DOMContentLoaded', () => {
    fetch('/nav.html')
      .then(response => {
        if (!response.ok) throw new Error('네비게이션 파일을 불러올 수 없습니다.');
        return response.text();
      })
      .then(data => {
        // 네비게이션 바 삽입
        const navPlaceholder = document.getElementById('nav-placeholder');
        navPlaceholder.innerHTML = data;
  
        // 모달 관련 이벤트 설정
        setupModalEvents();
      })
      .catch(error => console.error('네비게이션 파일을 불러오는 중 오류 발생:', error));
  });
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- 네비게이션 바 -->
<nav class="nav-bar">
    <div class="nav-left">
        <a href="main.jsp">
            <img src="../images/just_run.png" alt="러닝 코스 앱 로고" class="logo">
        </a>
        <div class="nav-menu">
            <a href="notice.jsp">공지사항</a>
            <% if("ADMIN".equals(session.getAttribute("role"))) { %>
                <a href="write_notice.jsp" class="admin-btn">공지사항 작성</a>
            <% } %>
            <a href="faq.jsp">FAQ</a>
            <% if("ADMIN".equals(session.getAttribute("role"))) { %>
                <a href="write_faq.jsp" class="admin-btn">FAQ 작성</a>
            <% } %>
            <% if("ADMIN".equals(session.getAttribute("role"))) { %>
                <a href="admin_inquiries.jsp">1:1 문의 관리</a>
            <% } else { %>
                <a href="inquiry.jsp">1:1 문의</a>
            <% } %>
            <a href="about.jsp">앱 설명</a>
        </div>
    </div>
    <div class="nav-right">
        <% if(session.getAttribute("user_id") == null) { %>
            <button class="btn btn-login" id="loginButton">로그인</button>
            <button class="btn btn-signup" id="signupButton">회원가입</button>
        <% } else { %>
            <div class="user-info">
                <span class="user-greeting">
                    <i class="fas fa-user-circle"></i>
                    <span class="user-name"><%= session.getAttribute("user_name") %></span>님
                    <% if("ADMIN".equals(session.getAttribute("role"))) { %>
                        <span class="admin-badge">[관리자]</span>
                    <% } %>
                </span>
                <button class="btn btn-logout" id="logoutButton">로그아웃</button>
            </div>
        <% } %>
    </div>
</nav>

<!-- 로그인 모달 -->
<div id="loginModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h2>로그인</h2>
            <span class="close">&times;</span>
        </div>
        <form class="login-form" id="loginForm" method="post" action="login_process.jsp">
            <input type="text" name="userId" placeholder="아이디" required style="background-color: #fff; color: #333; border: 1px solid #ddd;">
            <input type="password" name="password" placeholder="비밀번호" required style="background-color: #fff; color: #333; border: 1px solid #ddd;">
            <p class="error-message" style="color: #dc3545; display: none;"></p>
            <button type="submit" class="login-button">로그인</button>
        </form>
        <div class="login-footer">
            <a href="#" id="loginToSignup">회원가입</a>
        </div>
    </div>
</div>

<!-- 회원가입 모달 -->
<div id="signupModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h2>회원가입</h2>
            <span class="close">&times;</span>
        </div>
        <form class="login-form" id="signupForm" method="post" action="signup_process.jsp">
            <input type="text" name="userId" placeholder="아이디" required style="background-color: #fff; color: #333; border: 1px solid #ddd;">
            <p class="error-message" id="userIdError" style="color: #dc3545; font-weight: 600; margin: 2px 0; font-size: 12px;"></p>
            
            <input type="password" name="password" placeholder="비밀번호" required style="background-color: #fff; color: #333; border: 1px solid #ddd;">
            <p class="error-message" id="passwordError" style="color: #dc3545; font-weight: 600; margin: 2px 0; font-size: 12px;"></p>
            
            <input type="password" name="confirmPassword" placeholder="비밀번호 확인" required style="background-color: #fff; color: #333; border: 1px solid #ddd;">
            <p class="error-message" id="confirmPasswordError" style="color: #dc3545; font-weight: 600; margin: 2px 0; font-size: 12px;"></p>
            
            <input type="text" name="name" placeholder="이름" required style="background-color: #fff; color: #333; border: 1px solid #ddd;">
            <p class="error-message" id="nameError" style="color: #dc3545; font-weight: 600; margin: 2px 0; font-size: 12px;"></p>
            
            <button type="submit" class="login-button">가입하기</button>
        </form>
    </div>
</div>

<link rel="stylesheet" href="<%=request.getContextPath()%>/styles/nav.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<script>
    function initializeModals() {
        // 로그인 모달 관련 요소
        const loginButton = document.getElementById('loginButton');
        const loginModal = document.getElementById('loginModal');
        const loginCloseButton = loginModal.querySelector('.close');
        const loginForm = document.getElementById('loginForm');
        const loginErrorMessage = loginForm.querySelector('.error-message');

        // 회원가입 모달 관련 요소
        const signupButton = document.getElementById('signupButton');
        const signupModal = document.getElementById('signupModal');
        const signupCloseButton = signupModal.querySelector('.close');
        const signupForm = document.getElementById('signupForm');
        const signupErrorMessages = signupForm.querySelectorAll('.error-message');

        // 로그인 모달 이벤트
        loginButton?.addEventListener('click', () => {
            loginModal.style.display = 'flex';
        });

        loginCloseButton.addEventListener('click', () => {
            loginModal.style.display = 'none';
            loginErrorMessage.style.display = 'none';
        });

        // 회원가입 모달 이벤트
        signupButton?.addEventListener('click', () => {
            signupModal.style.display = 'flex';
        });

        signupCloseButton.addEventListener('click', () => {
            signupModal.style.display = 'none';
            signupErrorMessages.forEach(msg => msg.style.display = 'none');
        });

        // 모달 외부 클릭 시 닫기
        window.addEventListener('click', (event) => {
            if (event.target === loginModal) {
                loginModal.style.display = 'none';
                loginErrorMessage.style.display = 'none';
            }
            if (event.target === signupModal) {
                signupModal.style.display = 'none';
                signupErrorMessages.forEach(msg => msg.style.display = 'none');
            }
        });

        // 로그인 폼 제출
        loginForm.addEventListener('submit', async (e) => {
            e.preventDefault();
            const formData = new FormData(loginForm);
            
            try {
                // 폼 직접 제출
                loginForm.submit();
                
                // URL 파라미터 확인
                const urlParams = new URLSearchParams(window.location.search);
                const error = urlParams.get('error');
                const login = urlParams.get('login');
                
                if (error === 'invalid') {
                    alert('아이디 또는 비밀번호가 일치하지 않습니다.');
                } else if (error === 'database') {
                    alert('로그인 처리 중 오류가 발생했습니다.');
                } else if (login === 'success') {
                    window.location.reload();
                }
            } catch (error) {
                loginErrorMessage.textContent = '로그인 처리 중 오류가 발생했습니.';
                loginErrorMessage.style.display = 'block';
            }
        });

        // 회원가입 폼 제출
        signupForm.addEventListener('submit', async (e) => {
            e.preventDefault();
            
            // 유효성 검사
            const userId = signupForm.userId.value;
            const password = signupForm.password.value;
            const confirmPassword = signupForm.confirmPassword.value;
            const name = signupForm.name.value;
            let isValid = true;

            // 러 메시지 초기화
            signupErrorMessages.forEach(msg => msg.style.display = 'none');

            if (userId.length < 4) {
                document.getElementById('userIdError').textContent = '아이디는 4자 이상이어야 합니다.';
                document.getElementById('userIdError').style.display = 'block';
                isValid = false;
            }

            if (password.length < 6) {
                document.getElementById('passwordError').textContent = '비밀번호는 6자 이상이어야 합니다.';
                document.getElementById('passwordError').style.display = 'block';
                isValid = false;
            }

            if (password !== confirmPassword) {
                document.getElementById('confirmPasswordError').textContent = '비밀번호가 일치하지 않습니다.';
                document.getElementById('confirmPasswordError').style.display = 'block';
                isValid = false;
            }

            if (name.length < 2) {
                document.getElementById('nameError').textContent = '이름은 2자 이상어야 합니다.';
                document.getElementById('nameError').style.display = 'block';
                isValid = false;
            }

            if (isValid) {
                try {
                    // 폼 직접 제출
                    signupForm.submit();
                    
                    // URL 파라미터 확인
                    const urlParams = new URLSearchParams(window.location.search);
                    const error = urlParams.get('error');
                    const signup = urlParams.get('signup');
                    
                    if (error === 'duplicate') {
                        alert('이미 사용 중인 아이디입니다.');
                    } else if (error === 'database') {
                        alert('회원가입 처리 중 오류가 발생했습니다.');
                    } else if (signup === 'success') {
                        alert('회원가입이 완료되었습니다.');
                        signupModal.style.display = 'none';
                        loginModal.style.display = 'flex';
                    }
                } catch (error) {
                    alert('회원가입 처리 중 오류가 발생했습니다.');
                }
            }
        });

        // 로그아웃 튼 이벤트
        const logoutButton = document.getElementById('logoutButton');
        if(logoutButton) {
            logoutButton.addEventListener('click', () => {
                window.location.href = 'logout_process.jsp';
            });
        }

        // 로그인 모달의 회원가입 링크 클릭 이벤트
        const loginToSignupLink = document.getElementById('loginToSignup');
        loginToSignupLink.addEventListener('click', (e) => {
            e.preventDefault();
            loginModal.style.display = 'none';  // 로그인 모달 닫기
            signupModal.style.display = 'flex';  // 회원가입 모달 열기
            loginErrorMessage.style.display = 'none';  // 에러 메시지 초기화
        });
    }

    // URL 파라미터 확인 함수 수정
    function checkUrlParameters() {
        const urlParams = new URLSearchParams(window.location.search);
        const error = urlParams.get('error');
        const signup = urlParams.get('signup');
        
        if (error === 'duplicate') {
            alert('이미 사용 중인 아이디입니다.');
            // 파라미터 제거
            window.history.replaceState({}, '', window.location.pathname);
        } else if (error === 'database') {
            alert('회원가입 처리 중 오류가 발생했습니다.');
            // 파라미터 제거
            window.history.replaceState({}, '', window.location.pathname);
        } else if (signup === 'success') {
            alert('회원가입이 완료되었습니다.');
            // 파라미터 제거
            window.history.replaceState({}, '', window.location.pathname);
        }
    }

    document.addEventListener('DOMContentLoaded', () => {
        initializeModals();
        checkUrlParameters();
    });
</script> 
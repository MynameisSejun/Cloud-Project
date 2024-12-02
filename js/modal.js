function initializeLoginModal() {
    const loginButton = document.getElementById('loginButton');
    const loginModal = document.getElementById('loginModal');
    const closeButton = loginModal.querySelector('.close');
  
    loginButton.addEventListener('click', () => {
      loginModal.style.display = 'flex';
    });
  
    closeButton.addEventListener('click', () => {
      loginModal.style.display = 'none';
    });
  
    window.addEventListener('click', (event) => {
      if (event.target === loginModal) {
        loginModal.style.display = 'none';
      }
    });
  }
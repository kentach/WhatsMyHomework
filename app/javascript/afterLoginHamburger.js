document.addEventListener('turbo:load', () => {
  const sideMenu = document.getElementById('side-menu-after-login');
  const hamburgerBtn = document.getElementById('hamburger-btn-after-login');
  const menuOverlay = document.getElementById('menu-overlay-after-login');
  
  hamburgerBtn.addEventListener('click', () => {
    sideMenu.classList.toggle('open');
    hamburgerBtn.classList.toggle('active');
    menuOverlay.classList.toggle('active');
  });

  menuOverlay.addEventListener('click', () => {
    sideMenu.classList.remove('open');
    hamburgerBtn.classList.remove('active');
    menuOverlay.classList.remove('active');
  });
});

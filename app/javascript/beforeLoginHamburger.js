document.addEventListener('turbo:load', () => {
  const hamburgerIcon = document.querySelector('.logo-header i');
  const menu = document.getElementById('hamburger-menu');

  hamburgerIcon.addEventListener('click', () => {
    menu.classList.toggle('open');
    hamburgerIcon.classList.toggle('fa-list-ul')
    hamburgerIcon.classList.toggle('fa-xmark')
    hamburgerIcon.classList.toggle("active")
  })

})


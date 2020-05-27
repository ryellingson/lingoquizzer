const initSignUpModal = () => {
  var modalBtns = document.querySelectorAll('.modal-btn');
  var modalBg = document.querySelector('.modal-bg');
  var modalClose = document.querySelector('.modal-close');

  if (modalBtns.length > 0) {
    modalBtns.forEach(button => {
      button.addEventListener('click', function () {
        modalBg.classList.add('bg-active');
      });
    })

    modalClose.addEventListener('click', function () {
      modalBg.classList.remove('bg-active');
    });
  }
}
export { initSignUpModal }

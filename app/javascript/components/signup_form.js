const initInteractiveForm = () => {
  var inputs = document.querySelectorAll( '.interactive-form input[type=text], .interactive-form input[type=email], .interactive-form input[type=password]'  );
  if (inputs.length === 0) {
    return
  }
  for (let i = 0; i < inputs.length; i ++) {
    var inputEl = inputs[i];
    if( inputEl.value.trim() !== '' ) {
      inputEl.parentNode.classList.add( 'input--filled' );
    }
    inputEl.addEventListener( 'focus', onFocus );
    inputEl.addEventListener( 'blur', onBlur );
  }

  const passwordInput = document.querySelector("#user_password");
  const passwordConfirmation = document.querySelector("#user_password_confirmation");
  passwordConfirmation.addEventListener('input', () => {
    if (passwordInput.value !== passwordConfirmation.value) {
      passwordConfirmation.setCustomValidity("Passwords don't match!")
    } else {
      passwordConfirmation.setCustomValidity("");
    }
  });

  function onFocus( ev ) {
    ev.target.parentNode.classList.add( 'inputs--filled' );
  }

  function onBlur( ev ) {
    if ( ev.target.value.trim() === '' ) {
      ev.target.parentNode.classList.remove( 'inputs--filled' );
    } else if ( ev.target.checkValidity() == false ) {
      ev.target.parentNode.classList.add( 'inputs--invalid' );
      ev.target.addEventListener( 'input', liveValidation );
    } else if ( ev.target.checkValidity() == true ) {
      ev.target.parentNode.classList.remove( 'inputs--invalid' );
      ev.target.addEventListener( 'input', liveValidation );
    }
  }

  function liveValidation( ev ) {
    if ( ev.target.checkValidity() == false ) {
      ev.target.parentNode.classList.add( 'inputs--invalid' );
    } else {
      ev.target.parentNode.classList.remove( 'inputs--invalid' );
    }
  }

  var submitBtn = document.querySelector( '.interactive-form input[type=submit]' );
  submitBtn.addEventListener( 'click', onSubmit );

  function onSubmit( ev ) {
    var inputsWrappers = ev.target.parentNode.querySelectorAll( 'span' );
    for (let i = 0; i < inputsWrappers.length; i ++) {
      input = inputsWrappers[i].querySelector( 'input[type=text], input[type=email], input[type=password' );
      if ( input.checkValidity() == false ) {
        inputsWrappers[i].classList.add( 'inputs--invalid' );
      } else if ( input.checkValidity() == true ) {
        inputsWrappers[i].classList.remove( 'inputs--invalid' );
      }
    }
  }
}

export { initInteractiveForm }

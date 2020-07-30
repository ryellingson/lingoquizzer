const initDropDowns = () => {

  const startDropDownFromSelector = (selector) => {
    const dropdown = document.querySelector(selector);
    if (dropdown) {
      const trigger = dropdown.querySelector(".dropdown-trigger");
      trigger.addEventListener('click', () => {
        dropdown.classList.toggle("active");
      });
    }
  }
  startDropDownFromSelector("#login-dropdown");
  startDropDownFromSelector("#contact-dropdown");
  startDropDownFromSelector("#hamburger");
}

export { initDropDowns }

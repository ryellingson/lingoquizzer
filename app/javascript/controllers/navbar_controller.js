import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "toggle", "nav" ]

  connect() {

  }

  showMenu() {
    console.log('inside show menu');
    this.navTarget.classList.toggle('show');
  }

  showSignUpModal() {
    Swal.fire({
      title: 'Sign Up',
      html: `<%= form_for(resource, as: resource_name, url: registration_path(resource_name), remote: true) do |f| %>

             <% end %>`,
      confirmButtonText: 'Sign in',
      focusConfirm: false,
      preConfirm: () => {
        const username = Swal.getPopup().querySelector('#username').value
        const password = Swal.getPopup().querySelector('#password').value
        if (!username || !password) {
          Swal.showValidationMessage(`Please enter username and password`)
        }
        return { username: username, password: password }
      }
      }).then((result) => {
        Swal.fire(`
           Welcome to the community ${result.value.username}!
        `.trim())
      })
    }
}

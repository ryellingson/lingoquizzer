class ContactController < ApplicationController
  def send_message
    contact_form = ContactForm.new(contact_form_params)
    contact_form.deliver
    skip_authorization
  end

  private

  def contact_form_params
    if user_signed_in? && current_user.email.present?
      params[:contact_form][:email] = current_user.email
    end
    params.require(:contact_form).permit(:email, :subject, :message, :file)
  end
end

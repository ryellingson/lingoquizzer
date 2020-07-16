class ConversationsController < ApplicationController
  before_action :set_language


  private

  def set_language
    @language = Language.find_by(language_code: params[:lang])
  end


      # en: "https://www.youtube.com/embed/B1ed-pfqdZg"
      # ja: "https://www.youtube.com/embed/45vSd2dLaQU"
      # fr: "https://www.youtube.com/embed/ujDtm0hZyII"
      # es: "https://www.youtube.com/embed/lO9X-7beRa8"
end

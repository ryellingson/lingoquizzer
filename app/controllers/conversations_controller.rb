class ConversationsController < ApplicationController
  before_action :set_language, :set_slideshow_keywords

  private

  def set_language
    @language = Language.find_by(language_code: params[:lang])
  end

  def set_slideshow_keywords
    slideshow_keywords_data = {
      ja: "japan,kyushu,hokkaido",
      en: "england,united%20states,australia,new%20zealand",
      es: "mexico,spain,latin%20america,costa%20rica",
      fr: "france,cameroon,quebec"
    }
    @slideshow_keywords = slideshow_keywords_data[params[:lang].to_sym]
    @slide_urls = ["https://source.unsplash.com/900x900/?#{@slideshow_keywords}"]
  end
end

class ConversationsController < ApplicationController
  before_action :set_language
  before_action :set_slideshow_keywords

  private

  def set_language
    @language = Language.find_by(language_code: params[:lang])
  end

  def set_slideshow_keywords
    slideshow_keywords_data = {
      ja: "japan,kyushu,hokkaido,kanji",
      en: "england,united%20states,australia,new%20zealand,english",
      es: "mexico,spain,latin%20america,costa%20rica,ecuador,argentina,chile,colombia",
      fr: "france,cameroon,quebec,paris,avignon,bordeaux,brittany,lyon"
    }
    @slideshow_keywords = slideshow_keywords_data[@language.language_code.to_sym]
    @slide_urls = ["https://source.unsplash.com/900x900/?#{@slideshow_keywords}"]
  end
end

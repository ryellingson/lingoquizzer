class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  skip_after_action :verify_authorized, only: [ :home, :leaderboards ]

  def home
    home_images_path = Rails.root.join('app', 'assets', 'images', 'home_page_images')
    image_paths = home_images_path.entries.reject!(&File.method(:directory?)).sort!
    @slide_urls = image_paths.map {|image_path| ActionController::Base.helpers.image_url "home_page_images/" + image_path.to_s }
  end

  def leaderboards
    @games = Game.all
  end
end

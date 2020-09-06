module GamesHelper
  def calculate_time_from_seconds(seconds)
    Time.at(seconds).utc.strftime("%H:%M:%S")[3..]
  end

  def display_authors(game)
    author_results = game.authors.map do |author|
      link_to author['name'], author['url']
    end
    author_results.join(' and ')
  end
end

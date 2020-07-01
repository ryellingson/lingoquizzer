module GamesHelper
  def calculate_time_from_seconds(seconds)
    Time.at(seconds).utc.strftime("%H:%M:%S")[3..]
  end
end

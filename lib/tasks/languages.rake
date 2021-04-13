namespace :languages do
  desc "adds languages"
  task :generate do |task, args|
    puts "generating languages"

    languages_array = [
      {language_code: 'ja', name: 'japanese', video_url: "https://www.youtube.com/embed/45vSd2dLaQU"},
      {language_code: 'en', name: 'english', video_url: "https://www.youtube.com/embed/B1ed-pfqdZg"},
      {language_code: 'es', name: 'spanish', video_url: "https://www.youtube.com/embed/lO9X-7beRa8"},
      {language_code: 'fr', name: 'french', video_url: "https://www.youtube.com/embed/ujDtm0hZyII"}
    ]

    languages_array.each { |language| Language.find_or_create_by(language) }


    puts "おわり"
  end
end

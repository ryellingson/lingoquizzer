# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:

require 'json'

puts "destroying previous data"

puts "Language"
Language.destroy_all

puts "Game"
Game.destroy_all

puts "User"
User.destroy_all

puts "Comment"
Comment.destroy_all

puts "Post"
Post.destroy_all

puts "generating users"

usernames = ["test1", "test2", "test3", "test4", "test5", "test6", "test7", "test8", "test9", "test10", "test11", "test12", "test13", "test14", "test15"]

usernames.each do |username|
  User.create(username: username, email: "#{username}#{'@example.com'}", password: "#{username}#{'pass'}", password_confirmation: "#{username}#{'pass'}")
end

User.create(username: "admin1", email: "admin1@go.com", password: "admin1pass", password_confirmation: "admin1pass", admin: true)

puts "generating languages"

language_names = { ja: "japanese", es: "spanish", en: "english", fr: "french" }

language_names.each do |code, language|
  Language.create(language_code: code, name: language)
end

japanese = Language.find_by(name: "japanese")

puts "generating posts"

100.times do
  post = Post.new(title: Faker::ChuckNorris.fact, language: Language.all.sample, user: User.all.sample)
  post.content = Faker::Lorem.paragraphs(number: rand(1...5)).join
  post.save
end
# "table_game" = Genre.create(name: "table_game games")

puts "おはよう"

puts "checking to see if Hiragana 1 exists, if not creating it"

hiragana_1 = Game.find_or_create_by(name: "Hiragana 1", question_header: "Hiragana", language: japanese, genre: "table_game", difficulty: "beginner", category: "typing", character_type: "kana", play_time: 120, score: 2, description: File.read(Rails.root + 'db/data/japanese/descriptions/hiragana_1.md'))

# if found?

puts "game created"
puts "parsing hiragana_1 json"

hiragana_1_data = JSON.parse(File.read(Rails.root + 'db/data/japanese/hiragana_1.json'))

puts "parsed"
puts "populating game with problems..."

hiragana_1 = Game.find_by(name: "Hiragana 1")

hiragana_1_data.each do |problem_data|
  problem = Problem.find_or_create_by!(game: hiragana_1, question: problem_data["character"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["romanization"], character_type: "romaji")
end

puts "job done"
puts "Hiragana 1 is ready よしよし"

puts "次"

puts "checking to see if Hiragana 2 exists, if not creating it"

hiragana_2 = Game.find_or_create_by(name: "Hiragana 2", question_header: "Hiragana", language: japanese, genre: "table_game", difficulty: "intermediate", category: "typing", character_type: "kana", play_time: 180, score: 2, description: File.read(Rails.root + 'db/data/japanese/descriptions/hiragana_2.md'))

# if found?

puts "game created"
puts "parsing hiragana_2 json"

hiragana_2_data = JSON.parse(File.read(Rails.root + 'db/data/japanese/hiragana_2.json'))

puts "parsed"
puts "populating game with problems..."

hiragana_2_data.each do |problem_data|
 problem = Problem.find_or_create_by!(game: hiragana_2, question: problem_data["character"])
 answer = Answer.find_or_create_by!(problem: problem, data: problem_data["romanization"], character_type: "romaji")
end

puts "job done"
puts "Hiragana 2 is ready よしししししし"

puts "次"

puts "checking to see if Ultimate Hiragana exists, if not creating it"

ultimate_hiragana = Game.find_or_create_by(name: "Ultimate Hiragana", question_header: "Hiragana", language: japanese, genre: "table_game", difficulty: "advanced", category: "typing", character_type: "kana", play_time: 240, score: 2, description: File.read(Rails.root + 'db/data/japanese/descriptions/ultimate_hiragana.md'))

# if found?

puts "game created"
puts "parsing ultimate_hiragana json"

ultimate_hiragana_data = JSON.parse(File.read(Rails.root + 'db/data/japanese/ultimate_hiragana.json'))

puts "parsed"
puts "populating game with problems..."

ultimate_hiragana_data.each do |problem_data|
  problem = Problem.find_or_create_by!(game: ultimate_hiragana, question: problem_data["character"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["romanization"], character_type: "romaji")
end

puts "job done"
puts "Ultimate Hiragana is ready すごい！"

puts "次"

puts "ヘロ"

puts "checking to see if Katakana 1 exists, if not creating it"

katakana_1 = Game.find_or_create_by(name: "Katakana 1", question_header: "Katakana", language: japanese, genre: "table_game", difficulty: "beginner", category: "typing", character_type: "kana", play_time: 120, score: 2, description: File.read(Rails.root + 'db/data/japanese/descriptions/katakana_1.md'))

puts "game created"
puts "parsing katakana json"

katakana_1_data = JSON.parse(File.read(Rails.root + 'db/data/japanese/katakana_1.json'))

puts "parsed"
puts "populating game with problems..."

katakana_1_data.each do |problem_data|
  problem = Problem.find_or_create_by!(game: katakana_1, question: problem_data["character"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["romanization"], character_type: "romaji")
end

puts "job done"
puts "Katakana 1 is ready レズゴ"

puts "次"

puts "checking to see if Katakana 2 exists, if not creating it"

katakana_2 = Game.find_or_create_by(name: "Katakana 2", question_header: "Katakana", language: japanese, genre: "table_game", difficulty: "intermediate", category: "typing", character_type: "kana", play_time: 180, score: 2, description: File.read(Rails.root + 'db/data/japanese/descriptions/katakana_2.md'))

puts "game created"
puts "parsing katakana_2 json"

katakana_2_data = JSON.parse(File.read(Rails.root + 'db/data/japanese/katakana_2.json'))

puts "parsed"
puts "populating game with problems..."

katakana_2_data.each do |problem_data|
 problem = Problem.find_or_create_by!(game: katakana_2, question: problem_data["character"])
Answer.find_or_create_by!(problem: problem, data: problem_data["romanization"], character_type: "romaji")
end

puts "job done"
puts "Katakana 2 is ready ネクストレベル"

puts "次"

puts "checking to see if Ultimate Katakana exists, if not creating it"

ultimate_katakana = Game.find_or_create_by(name: "Ultimate Katakana", question_header: "Katakana", language: japanese, genre: "table_game", difficulty: "advanced", category: "typing", character_type: "kana", play_time: 240, score: 2, description: File.read(Rails.root + 'db/data/japanese/descriptions/ultimate_katakana.md'))

puts "game created"
puts "parsing utimate_katakana json"

ultimate_katakana_data = JSON.parse(File.read(Rails.root + 'db/data/japanese/ultimate_katakana.json'))

puts "parsed"
puts "populating game with problems..."

ultimate_katakana_data.each do |problem_data|
  problem = Problem.find_or_create_by!(game: ultimate_katakana, question: problem_data["character"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["romanization"], character_type: "romaji")
end

puts "job done"
puts "Ultimate Katakana is ready アルティメート"

puts "次"

# puts "checking to see if Kana vs Kana 1 exists, if not creating it"

# kana_vs_kana_1 = Game.find_or_create_by(name: "Kana vs Kana 1")

# puts "game created"
# puts "parsing kana_vs_kana_1 json"

# kana_vs_kana_1_data = JSON.parse(File.read(Rails.root + 'db/data/japanese/kana_vs_kana_1.json'))

# puts "parsed"
# puts "populating game with problems..."

# kana_vs_kana_1_data.each do |problem_data|
#   Problem.find_or_create_by!(game: kana_vs_kana_1, question: problem_data["character"], answer: problem_data["romanization"])
# end

# puts "job done"
# puts "Kana vs Kana 1 is ready ハは"

puts "次"

puts "ワンワン"

puts "creating animals"

animals = Game.find_or_create_by(name: "動物", icon_based: true, question_header: "動物", language: japanese, genre: "table_game", difficulty: "intermediate", category: "vocabulary", play_time: 180, score: 5, description: File.read(Rails.root + 'db/data/japanese/descriptions/animals.md'))

puts "game created"
puts "parsing json"

animals_data = JSON.parse(File.read(Rails.root + 'db/data/japanese/animals.json'))

puts "parsed"
puts "populating game with problems..."

animals_data.each do |problem_data|
  problem = Problem.find_or_create_by!(game: animals, question: problem_data["problem_icon"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["kanji"], character_type: "kanji")
  Answer.find_or_create_by!(problem: problem, data: problem_data["kana"], character_type: "kana")
  Answer.find_or_create_by!(problem: problem, data: problem_data["romaji"], character_type: "romaji")
end

puts "job done"
puts "Animals is ready にゃんにゃん"

puts "次"

puts "creating around the house"

around_the_house = Game.find_or_create_by(name: "家の周り", icon_based: true, question_header: "質問", language: japanese, genre: "table_game", difficulty: "intermediate", category: "vocabulary", play_time: 180, score: 5, description: File.read(Rails.root + 'db/data/japanese/descriptions/around_the_house.md'))

puts "game created"
puts "parsing json"

around_the_house_data = JSON.parse(File.read(Rails.root + 'db/data/japanese/around_the_house.json'))

puts "parsed"
puts "populating game with problems..."

around_the_house_data.each do |problem_data|
  problem = Problem.find_or_create_by!(game: around_the_house, question: problem_data["question"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["kanji"], character_type: "kanji")
  Answer.find_or_create_by!(problem: problem, data: problem_data["kana"], character_type: "kana")
  Answer.find_or_create_by!(problem: problem, data: problem_data["romaji"], character_type: "romaji")
end

puts "job done"
puts "around the house is ready"

puts "次"

puts "creating countries"

countries = Game.find_or_create_by(name: "国々", icon_based: true, question_header: "国々", language: japanese, genre: "table_game", difficulty: "advanced", category: "vocabulary", play_time: 180, score: 5, description: File.read(Rails.root + 'db/data/japanese/descriptions/countries.md'))

puts "game created"
puts "parsing json"

countries_data = JSON.parse(File.read(Rails.root + 'db/data/japanese/countries.json'))

puts "parsed"
puts "populating game with problems..."

countries_data.each do |problem_data|
  problem = Problem.find_or_create_by!(game: countries, question: problem_data["question"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["kanji"], character_type: "kanji")
  Answer.find_or_create_by!(problem: problem, data: problem_data["kana"], character_type: "kana")
  Answer.find_or_create_by!(problem: problem, data: problem_data["romaji"], character_type: "romaji")
end

puts "job done"
puts "countries is ready"

puts "次"

puts "creating emotions and feelings"

emotions_and_feelings = Game.find_or_create_by(name: "感情", icon_based: true, question_header: "感情", language: japanese, genre: "table_game", difficulty: "advanced", category: "vocabulary", play_time: 180, score: 5, description: File.read(Rails.root + 'db/data/japanese/descriptions/emotions_and_feelings.md'))

puts "game created"
puts "parsing json"

emotions_and_feelings_data = JSON.parse(File.read(Rails.root + 'db/data/japanese/emotions_and_feelings.json'))

puts "parsed"
puts "populating game with problems..."

emotions_and_feelings_data.each do |problem_data|
  problem = Problem.find_or_create_by!(game: emotions_and_feelings, question: problem_data["question"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["kanji"], character_type: "kanji")
  Answer.find_or_create_by!(problem: problem, data: problem_data["kana"], character_type: "kana")
  Answer.find_or_create_by!(problem: problem, data: problem_data["romaji"], character_type: "romaji")
end

puts "job done"
puts "emotions and feelings is ready"

puts "次"

puts "creating food"

food = Game.find_or_create_by(name: "食べ物", icon_based: true, question_header: "食べ物", language: japanese, genre: "table_game", difficulty: "intermediate", category: "vocabulary", play_time: 180, score: 5, description: File.read(Rails.root + 'db/data/japanese/descriptions/food.md'))

puts "game created"
puts "parsing json"

food_data = JSON.parse(File.read(Rails.root + 'db/data/japanese/food.json'))

puts "parsed"
puts "populating game with problems..."

food_data.each do |problem_data|
  problem = Problem.find_or_create_by!(game: food, question: problem_data["question"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["kanji"], character_type: "kanji")
  Answer.find_or_create_by!(problem: problem, data: problem_data["kana"], character_type: "kana")
  Answer.find_or_create_by!(problem: problem, data: problem_data["romaji"], character_type: "romaji")
end

puts "job done"
puts "food is ready"

puts "次"

puts "creating nature and weather"

nature_and_weather = Game.find_or_create_by(name: "自然と天気", icon_based: true, question_header: "質問", language: japanese, genre: "table_game", difficulty: "intermediate", category: "vocabulary", play_time: 180, score: 5, description: File.read(Rails.root + 'db/data/japanese/descriptions/nature_and_weather.md'))

puts "game created"
puts "parsing json"

nature_and_weather_data = JSON.parse(File.read(Rails.root + 'db/data/japanese/nature_and_weather.json'))

puts "parsed"
puts "populating game with problems..."

nature_and_weather_data.each do |problem_data|
  problem = Problem.find_or_create_by!(game: nature_and_weather, question: problem_data["question"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["kanji"], character_type: "kanji")
  Answer.find_or_create_by!(problem: problem, data: problem_data["kana"], character_type: "kana")
  Answer.find_or_create_by!(problem: problem, data: problem_data["romaji"], character_type: "romaji")
end

puts "job done"
puts "nature and weather is ready"

puts "次"

puts "creating people and jobs"

people_and_jobs = Game.find_or_create_by(name: "人と仕事", icon_based: true, question_header: "質問", language: japanese, genre: "table_game", difficulty: "intermediate", category: "vocabulary", play_time: 180, score: 5, description: File.read(Rails.root + 'db/data/japanese/descriptions/people_and_jobs.md'))

puts "game created"
puts "parsing json"

people_and_jobs_data = JSON.parse(File.read(Rails.root + 'db/data/japanese/people_and_jobs.json'))

puts "parsed"
puts "populating game with problems..."

people_and_jobs_data.each do |problem_data|
  problem = Problem.find_or_create_by!(game: people_and_jobs, question: problem_data["question"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["kanji"], character_type: "kanji")
  Answer.find_or_create_by!(problem: problem, data: problem_data["kana"], character_type: "kana")
  Answer.find_or_create_by!(problem: problem, data: problem_data["romaji"], character_type: "romaji")
end

puts "job done"
puts "people and jobs is ready"

puts "次"

puts "creating sports and activities"

sports_and_activites = Game.find_or_create_by(name: "スポーツと活動", icon_based: true, question_header: "質問", language: japanese, genre: "table_game", difficulty: "intermediate", category: "vocabulary", play_time: 180, score: 5, description: File.read(Rails.root + 'db/data/japanese/descriptions/sports_and_activities.md'))

puts "game created"
puts "parsing json"

sports_and_activites_data = JSON.parse(File.read(Rails.root + 'db/data/japanese/sports_and_activites.json'))

puts "parsed"
puts "populating game with problems..."

sports_and_activites_data.each do |problem_data|
  problem = Problem.find_or_create_by!(game: sports_and_activites, question: problem_data["question"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["kanji"], character_type: "kanji")
  Answer.find_or_create_by!(problem: problem, data: problem_data["kana"], character_type: "kana")
  Answer.find_or_create_by!(problem: problem, data: problem_data["romaji"], character_type: "romaji")
end

puts "job done"
puts "sports and activities is ready"

puts "次"

puts "creating tech and tools"

tech_and_tools = Game.find_or_create_by(name: "技術とツール", icon_based: true, question_header: "質問", language: japanese, genre: "table_game", difficulty: "intermediate", category: "vocabulary", play_time: 180, score: 5, description: File.read(Rails.root + 'db/data/japanese/descriptions/tech_and_tools.md'))

puts "game created"
puts "parsing json"

tech_and_tools_data = JSON.parse(File.read(Rails.root + 'db/data/japanese/tech_and_tools.json'))

puts "parsed"
puts "populating game with problems..."

tech_and_tools_data.each do |problem_data|
  problem = Problem.find_or_create_by!(game: tech_and_tools, question: problem_data["question"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["kanji"], character_type: "kanji")
  Answer.find_or_create_by!(problem: problem, data: problem_data["kana"], character_type: "kana")
  Answer.find_or_create_by!(problem: problem, data: problem_data["romaji"], character_type: "romaji")
end

puts "job done"
puts "tech and tools is ready"

puts "次"

puts "creating travel and places"

travel_and_places = Game.find_or_create_by(name: "旅行と場所", icon_based: true, question_header: "質問", language: japanese, genre: "table_game", difficulty: "intermediate", category: "vocabulary", play_time: 180, score: 5, description: File.read(Rails.root + 'db/data/japanese/descriptions/travel_and_places.md'))

puts "game created"
puts "parsing json"

travel_and_places_data = JSON.parse(File.read(Rails.root + 'db/data/japanese/travel_and_places.json'))

puts "parsed"
puts "populating game with problems..."

travel_and_places_data.each do |problem_data|
  problem = Problem.find_or_create_by!(game: travel_and_places, question: problem_data["question"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["kanji"], character_type: "kanji")
  Answer.find_or_create_by!(problem: problem, data: problem_data["kana"], character_type: "kana")
  Answer.find_or_create_by!(problem: problem, data: problem_data["romaji"], character_type: "romaji")
end

puts "job done"
puts "travel and places is ready"

puts "japanese finished"

puts "-----------"

puts "starting english"

puts "creating animals"

animals_en = Game.find_or_create_by(name: "Animals", icon_based: true, question_header: "Animal", language: english, genre: "table_game", difficulty: "intermediate", category: "vocabulary", play_time: 180, score: 5, description: File.read(Rails.root + 'db/data/english/descriptions/animals.md'))

puts "game created"
puts "parsing json"

animals_en_data = JSON.parse(File.read(Rails.root + 'db/data/english/animals.json'))

puts "parsed"
puts "populating game with problems..."

animals_en_data.each do |problem_data|
  problem = Problem.find_or_create_by!(game: animals_en, question: problem_data["problem_icon"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["kanji"], character_type: "kanji")
  Answer.find_or_create_by!(problem: problem, data: problem_data["kana"], character_type: "kana")
  Answer.find_or_create_by!(problem: problem, data: problem_data["romaji"], character_type: "romaji")
end

puts "job done"
puts "Animals is ready"

puts "次"

puts "creating around the house"

around_the_house_en = Game.find_or_create_by(name: "Around the House", icon_based: true, question_header: "Question", language: english, genre: "table_game", difficulty: "intermediate", category: "vocabulary", play_time: 180, score: 5, description: File.read(Rails.root + 'db/data/english/descriptions/around_the_house.md'))

puts "game created"
puts "parsing json"

around_the_house_data_en = JSON.parse(File.read(Rails.root + 'db/data/english/around_the_house.json'))

puts "parsed"
puts "populating game with problems..."

around_the_house_data_en.each do |problem_data|
  problem = Problem.find_or_create_by!(game: around_the_house_en, question: problem_data["question"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["kanji"], character_type: "kanji")
  Answer.find_or_create_by!(problem: problem, data: problem_data["kana"], character_type: "kana")
  Answer.find_or_create_by!(problem: problem, data: problem_data["romaji"], character_type: "romaji")
end

puts "job done"
puts "around the house is ready"

puts "次"

puts "creating countries"

countries_en = Game.find_or_create_by(name: "Countries", icon_based: true, question_header: "Country", language: english, genre: "table_game", difficulty: "advanced", category: "vocabulary", play_time: 180, score: 5, description: File.read(Rails.root + 'db/data/english/descriptions/countries.md'))

puts "game created"
puts "parsing json"

countries_data_en = JSON.parse(File.read(Rails.root + 'db/data/english/countries.json'))

puts "parsed"
puts "populating game with problems..."

countries_data_en.each do |problem_data|
  problem = Problem.find_or_create_by!(game: countries_en, question: problem_data["question"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["kanji"], character_type: "kanji")
  Answer.find_or_create_by!(problem: problem, data: problem_data["kana"], character_type: "kana")
  Answer.find_or_create_by!(problem: problem, data: problem_data["romaji"], character_type: "romaji")
end

puts "job done"
puts "countries is ready"

puts "次"

puts "creating emotions and feelings"

emotions_and_feelings_en = Game.find_or_create_by(name: "Emotions and Feelings", icon_based: true, question_header: "Question", language: english, genre: "table_game", difficulty: "advanced", category: "vocabulary", play_time: 180, score: 5, description: File.read(Rails.root + 'db/data/english/descriptions/emotions_and_feelings.md'))

puts "game created"
puts "parsing json"

emotions_and_feelings_data_en = JSON.parse(File.read(Rails.root + 'db/data/english/emotions_and_feelings.json'))

puts "parsed"
puts "populating game with problems..."

emotions_and_feelings_data_en.each do |problem_data|
  problem = Problem.find_or_create_by!(game: emotions_and_feelings_en, question: problem_data["question"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["kanji"], character_type: "kanji")
  Answer.find_or_create_by!(problem: problem, data: problem_data["kana"], character_type: "kana")
  Answer.find_or_create_by!(problem: problem, data: problem_data["romaji"], character_type: "romaji")
end

puts "job done"
puts "emotions and feelings is ready"

puts "次"

puts "creating food"

food_en = Game.find_or_create_by(name: "Food", icon_based: true, question_header: "Food", language: english, genre: "table_game", difficulty: "intermediate", category: "vocabulary", play_time: 180, score: 5, description: File.read(Rails.root + 'db/data/english/descriptions/food.md'))

puts "game created"
puts "parsing json"

food_data = JSON.parse(File.read(Rails.root + 'db/data/english/food.json'))

puts "parsed"
puts "populating game with problems..."

food_data_en.each do |problem_data|
  problem = Problem.find_or_create_by!(game: food_en, question: problem_data["question"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["kanji"], character_type: "kanji")
  Answer.find_or_create_by!(problem: problem, data: problem_data["kana"], character_type: "kana")
  Answer.find_or_create_by!(problem: problem, data: problem_data["romaji"], character_type: "romaji")
end

puts "job done"
puts "food is ready"

puts "次"

puts "creating nature and weather"

nature_and_weather_en = Game.find_or_create_by(name: "Nature and Weather", icon_based: true, question_header: "Question", language: english, genre: "table_game", difficulty: "intermediate", category: "vocabulary", play_time: 180, score: 5, description: File.read(Rails.root + 'db/data/english/descriptions/nature_and_weather.md'))

puts "game created"
puts "parsing json"

nature_and_weather_data_en = JSON.parse(File.read(Rails.root + 'db/data/english/nature_and_weather.json'))

puts "parsed"
puts "populating game with problems..."

nature_and_weather_data_en.each do |problem_data|
  problem = Problem.find_or_create_by!(game: nature_and_weather_en, question: problem_data["question"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["kanji"], character_type: "kanji")
  Answer.find_or_create_by!(problem: problem, data: problem_data["kana"], character_type: "kana")
  Answer.find_or_create_by!(problem: problem, data: problem_data["romaji"], character_type: "romaji")
end

puts "job done"
puts "nature and weather is ready"

puts "次"

puts "creating people and jobs"

people_and_jobs_en = Game.find_or_create_by(name: "People and Jobs", icon_based: true, question_header: "Question", language: english, genre: "table_game", difficulty: "intermediate", category: "vocabulary", play_time: 180, score: 5, description: File.read(Rails.root + 'db/data/english/descriptions/people_and_jobs.md'))

puts "game created"
puts "parsing json"

people_and_jobs_data_en = JSON.parse(File.read(Rails.root + 'db/data/english/people_and_jobs.json'))

puts "parsed"
puts "populating game with problems..."

people_and_jobs_data_en.each do |problem_data|
  problem = Problem.find_or_create_by!(game: people_and_jobs_en, question: problem_data["question"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["kanji"], character_type: "kanji")
  Answer.find_or_create_by!(problem: problem, data: problem_data["kana"], character_type: "kana")
  Answer.find_or_create_by!(problem: problem, data: problem_data["romaji"], character_type: "romaji")
end

puts "job done"
puts "people and jobs is ready"

puts "次"

puts "creating sports and activities"

sports_and_activites_en = Game.find_or_create_by(name: "Sports and Activities", icon_based: true, question_header: "Question", language: english, genre: "table_game", difficulty: "intermediate", category: "vocabulary", play_time: 180, score: 5, description: File.read(Rails.root + 'db/data/english/descriptions/sports_and_activities.md'))

puts "game created"
puts "parsing json"

sports_and_activites_data_en = JSON.parse(File.read(Rails.root + 'db/data/english/sports_and_activites.json'))

puts "parsed"
puts "populating game with problems..."

sports_and_activites_data_en.each do |problem_data|
  problem = Problem.find_or_create_by!(game: sports_and_activites_en, question: problem_data["question"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["kanji"], character_type: "kanji")
  Answer.find_or_create_by!(problem: problem, data: problem_data["kana"], character_type: "kana")
  Answer.find_or_create_by!(problem: problem, data: problem_data["romaji"], character_type: "romaji")
end

puts "job done"
puts "sports and activities is ready"

puts "次"

puts "creating tech and tools"

tech_and_tools_en = Game.find_or_create_by(name: "Tech and Tools", icon_based: true, question_header: "Question", language: english, genre: "table_game", difficulty: "intermediate", category: "vocabulary", play_time: 180, score: 5, description: File.read(Rails.root + 'db/data/english/descriptions/tech_and_tools.md'))

puts "game created"
puts "parsing json"

tech_and_tools_data_en = JSON.parse(File.read(Rails.root + 'db/data/english/tech_and_tools.json'))

puts "parsed"
puts "populating game with problems..."

tech_and_tools_data_en.each do |problem_data|
  problem = Problem.find_or_create_by!(game: tech_and_tools_en, question: problem_data["question"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["kanji"], character_type: "kanji")
  Answer.find_or_create_by!(problem: problem, data: problem_data["kana"], character_type: "kana")
  Answer.find_or_create_by!(problem: problem, data: problem_data["romaji"], character_type: "romaji")
end

puts "job done"
puts "tech and tools is ready"

puts "次"

puts "creating travel and places"

travel_and_places_en = Game.find_or_create_by(name: "Travel and Places", icon_based: true, question_header: "Question", language: english, genre: "table_game", difficulty: "intermediate", category: "vocabulary", play_time: 180, score: 5, description: File.read(Rails.root + 'db/data/english/descriptions/travel_and_places.md'))

puts "game created"
puts "parsing json"

travel_and_places_data_en = JSON.parse(File.read(Rails.root + 'db/data/english/travel_and_places.json'))

puts "parsed"
puts "populating game with problems..."

travel_and_places_data_en.each do |problem_data|
  problem = Problem.find_or_create_by!(game: travel_and_places_en, question: problem_data["question"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["kanji"], character_type: "kanji")
  Answer.find_or_create_by!(problem: problem, data: problem_data["kana"], character_type: "kana")
  Answer.find_or_create_by!(problem: problem, data: problem_data["romaji"], character_type: "romaji")
end

puts "job done"
puts "travel and places is ready"

puts "english finished"

puts "-------"

puts "starting french"

puts "creating animals"

animals_fr = Game.find_or_create_by(name: "les animaux", icon_based: true, question_header: "la question", language: french, genre: "table_game", difficulty: "intermediate", category: "vocabulary", play_time: 180, score: 5, description: File.read(Rails.root + 'db/data/french/descriptions/animals.md'))

puts "game created"
puts "parsing json"

animals_data_fr = JSON.parse(File.read(Rails.root + 'db/data/french/animals.json'))

puts "parsed"
puts "populating game with problems..."

animals_data_fr.each do |problem_data|
  problem = Problem.find_or_create_by!(game: animals_fr, question: problem_data["problem_icon"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["kanji"], character_type: "kanji")
  Answer.find_or_create_by!(problem: problem, data: problem_data["kana"], character_type: "kana")
  Answer.find_or_create_by!(problem: problem, data: problem_data["romaji"], character_type: "romaji")
end

puts "job done"
puts "Animals is ready にゃんにゃん"

puts "次"

puts "creating around the house"

around_the_house_fr = Game.find_or_create_by(name: "autour de la maison", icon_based: true, question_header: "la question", language: french, genre: "table_game", difficulty: "intermediate", category: "vocabulary", play_time: 180, score: 5, description: File.read(Rails.root + 'db/data/french/descriptions/around_the_house.md'))

puts "game created"
puts "parsing json"

around_the_house_data_fr = JSON.parse(File.read(Rails.root + 'db/data/french/around_the_house.json'))

puts "parsed"
puts "populating game with problems..."

around_the_house_data_fr.each do |problem_data|
  problem = Problem.find_or_create_by!(game: around_the_house_fr, question: problem_data["question"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["kanji"], character_type: "kanji")
  Answer.find_or_create_by!(problem: problem, data: problem_data["kana"], character_type: "kana")
  Answer.find_or_create_by!(problem: problem, data: problem_data["romaji"], character_type: "romaji")
end

puts "job done"
puts "around the house is ready"

puts "次"

puts "creating countries"

countries_fr = Game.find_or_create_by(name: "des pays", icon_based: true, question_header: "la question", language: french, genre: "table_game", difficulty: "advanced", category: "vocabulary", play_time: 180, score: 5, description: File.read(Rails.root + 'db/data/french/descriptions/countries.md'))

puts "game created"
puts "parsing json"

countries_data_fr = JSON.parse(File.read(Rails.root + 'db/data/french/countries.json'))

puts "parsed"
puts "populating game with problems..."

countries_data_fr.each do |problem_data|
  problem = Problem.find_or_create_by!(game: countries_fr, question: problem_data["question"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["kanji"], character_type: "kanji")
  Answer.find_or_create_by!(problem: problem, data: problem_data["kana"], character_type: "kana")
  Answer.find_or_create_by!(problem: problem, data: problem_data["romaji"], character_type: "romaji")
end

puts "job done"
puts "countries is ready"

puts "次"

puts "creating emotions and feelings"

emotions_and_feelings_fr = Game.find_or_create_by(name: "émotions et sentiments", icon_based: true, question_header: "la question", language: french, genre: "table_game", difficulty: "advanced", category: "vocabulary", play_time: 180, score: 5, description: File.read(Rails.root + 'db/data/french/descriptions/emotions_and_feelings.md'))

puts "game created"
puts "parsing json"

emotions_and_feelings_data_fr = JSON.parse(File.read(Rails.root + 'db/data/french/emotions_and_feelings.json'))

puts "parsed"
puts "populating game with problems..."

emotions_and_feelings_data_fr.each do |problem_data|
  problem = Problem.find_or_create_by!(game: emotions_and_feelings_fr, question: problem_data["question"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["kanji"], character_type: "kanji")
  Answer.find_or_create_by!(problem: problem, data: problem_data["kana"], character_type: "kana")
  Answer.find_or_create_by!(problem: problem, data: problem_data["romaji"], character_type: "romaji")
end

puts "job done"
puts "emotions and feelings is ready"

puts "次"

puts "creating food"

food_fr = Game.find_or_create_by(name: "aliments", icon_based: true, question_header: "la question", language: french, genre: "table_game", difficulty: "intermediate", category: "vocabulary", play_time: 180, score: 5, description: File.read(Rails.root + 'db/data/french/descriptions/food.md'))

puts "game created"
puts "parsing json"

food_data_fr = JSON.parse(File.read(Rails.root + 'db/data/french/food.json'))

puts "parsed"
puts "populating game with problems..."

food_data_fr.each do |problem_data|
  problem = Problem.find_or_create_by!(game: food_fr, question: problem_data["question"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["kanji"], character_type: "kanji")
  Answer.find_or_create_by!(problem: problem, data: problem_data["kana"], character_type: "kana")
  Answer.find_or_create_by!(problem: problem, data: problem_data["romaji"], character_type: "romaji")
end

puts "job done"
puts "food is ready"

puts "次"

puts "creating nature and weather"

nature_and_weather_fr = Game.find_or_create_by(name: "nature et météo", icon_based: true, question_header: "la question", language: french, genre: "table_game", difficulty: "intermediate", category: "vocabulary", play_time: 180, score: 5, description: File.read(Rails.root + 'db/data/french/descriptions/nature_and_weather.md'))

puts "game created"
puts "parsing json"

nature_and_weather_data_fr = JSON.parse(File.read(Rails.root + 'db/data/french/nature_and_weather.json'))

puts "parsed"
puts "populating game with problems..."

nature_and_weather_data_fr.each do |problem_data|
  problem = Problem.find_or_create_by!(game: nature_and_weather_fr, question: problem_data["question"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["kanji"], character_type: "kanji")
  Answer.find_or_create_by!(problem: problem, data: problem_data["kana"], character_type: "kana")
  Answer.find_or_create_by!(problem: problem, data: problem_data["romaji"], character_type: "romaji")
end

puts "job done"
puts "nature and weather is ready"

puts "次"

puts "creating people and jobs"

people_and_jobs_fr = Game.find_or_create_by(name: "les gens et les emplois", icon_based: true, question_header: "la question", language: french, genre: "table_game", difficulty: "intermediate", category: "vocabulary", play_time: 180, score: 5, description: File.read(Rails.root + 'db/data/french/descriptions/people_and_jobs.md'))

puts "game created"
puts "parsing json"

people_and_jobs_data_fr = JSON.parse(File.read(Rails.root + 'db/data/french/people_and_jobs.json'))

puts "parsed"
puts "populating game with problems..."

people_and_jobs_data_fr.each do |problem_data|
  problem = Problem.find_or_create_by!(game: people_and_jobs_fr, question: problem_data["question"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["kanji"], character_type: "kanji")
  Answer.find_or_create_by!(problem: problem, data: problem_data["kana"], character_type: "kana")
  Answer.find_or_create_by!(problem: problem, data: problem_data["romaji"], character_type: "romaji")
end

puts "job done"
puts "people and jobs is ready"

puts "次"

puts "creating sports and activities"

sports_and_activites_fr = Game.find_or_create_by(name: "sports et activités", icon_based: true, question_header: "la question", language: french, genre: "table_game", difficulty: "intermediate", category: "vocabulary", play_time: 180, score: 5, description: File.read(Rails.root + 'db/data/french/descriptions/sports_and_activities.md'))

puts "game created"
puts "parsing json"

sports_and_activites_data_fr = JSON.parse(File.read(Rails.root + 'db/data/french/sports_and_activites.json'))

puts "parsed"
puts "populating game with problems..."

sports_and_activites_data_fr.each do |problem_data|
  problem = Problem.find_or_create_by!(game: sports_and_activites_fr, question: problem_data["question"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["kanji"], character_type: "kanji")
  Answer.find_or_create_by!(problem: problem, data: problem_data["kana"], character_type: "kana")
  Answer.find_or_create_by!(problem: problem, data: problem_data["romaji"], character_type: "romaji")
end

puts "job done"
puts "sports and activities is ready"

puts "次"

puts "creating tech and tools"

tech_and_tools_fr = Game.find_or_create_by(name: "technologie et outils", icon_based: true, question_header: "la question", language: french, genre: "table_game", difficulty: "intermediate", category: "vocabulary", play_time: 180, score: 5, description: File.read(Rails.root + 'db/data/french/descriptions/tech_and_tools.md'))

puts "game created"
puts "parsing json"

tech_and_tools_data_fr = JSON.parse(File.read(Rails.root + 'db/data/french/tech_and_tools.json'))

puts "parsed"
puts "populating game with problems..."

tech_and_tools_data_fr.each do |problem_data|
  problem = Problem.find_or_create_by!(game: tech_and_tools_fr, question: problem_data["question"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["kanji"], character_type: "kanji")
  Answer.find_or_create_by!(problem: problem, data: problem_data["kana"], character_type: "kana")
  Answer.find_or_create_by!(problem: problem, data: problem_data["romaji"], character_type: "romaji")
end

puts "job done"
puts "tech and tools is ready"

puts "次"

puts "creating travel and places"

travel_and_places_fr = Game.find_or_create_by(name: "voyages et lieux", icon_based: true, question_header: "la question", language: french, genre: "table_game", difficulty: "intermediate", category: "vocabulary", play_time: 180, score: 5, description: File.read(Rails.root + 'db/data/french/descriptions/travel_and_places.md'))

puts "game created"
puts "parsing json"

travel_and_places_data_fr = JSON.parse(File.read(Rails.root + 'db/data/french/travel_and_places.json'))

puts "parsed"
puts "populating game with problems..."

travel_and_places_data.each_fr do |problem_data|
  problem = Problem.find_or_create_by!(game: travel_and_places_fr, question: problem_data["question"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["kanji"], character_type: "kanji")
  Answer.find_or_create_by!(problem: problem, data: problem_data["kana"], character_type: "kana")
  Answer.find_or_create_by!(problem: problem, data: problem_data["romaji"], character_type: "romaji")
end

puts "job done"
puts "travel and places is ready"

puts "french finished"

puts "--------"

puts "starting spanish"

puts "creating animals"

animals_es = Game.find_or_create_by(name: "los animales", icon_based: true, question_header: "la pregunta", language: spanish, genre: "table_game", difficulty: "intermediate", category: "vocabulary", play_time: 180, score: 5, description: File.read(Rails.root + 'db/data/spanish/descriptions/animals.md'))

puts "game created"
puts "parsing json"

animals_data_es = JSON.parse(File.read(Rails.root + 'db/data/spanish/animals.json'))

puts "parsed"
puts "populating game with problems..."

animals_data.each_es do |problem_data|
  problem = Problem.find_or_create_by!(game: animals_es, question: problem_data["problem_icon"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["kanji"], character_type: "kanji")
  Answer.find_or_create_by!(problem: problem, data: problem_data["kana"], character_type: "kana")
  Answer.find_or_create_by!(problem: problem, data: problem_data["romaji"], character_type: "romaji")
end

puts "job done"
puts "Animals is ready にゃんにゃん"

puts "次"

puts "creating around the house"

around_the_house_es = Game.find_or_create_by(name: "alrededor de la casa", icon_based: true, question_header: "la pregunta", language: spanish, genre: "table_game", difficulty: "intermediate", category: "vocabulary", play_time: 180, score: 5, description: File.read(Rails.root + 'db/data/spanish/descriptions/around_the_house.md'))

puts "game created"
puts "parsing json"

around_the_house_data_es = JSON.parse(File.read(Rails.root + 'db/data/spanish/around_the_house.json'))

puts "parsed"
puts "populating game with problems..."

around_the_house_data_es.each do |problem_data|
  problem = Problem.find_or_create_by!(game: around_the_house_es, question: problem_data["question"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["kanji"], character_type: "kanji")
  Answer.find_or_create_by!(problem: problem, data: problem_data["kana"], character_type: "kana")
  Answer.find_or_create_by!(problem: problem, data: problem_data["romaji"], character_type: "romaji")
end

puts "job done"
puts "around the house is ready"

puts "次"

puts "creating countries"

countries_es = Game.find_or_create_by(name: "los países", icon_based: true, question_header: "la pregunta", language: spanish, genre: "table_game", difficulty: "advanced", category: "vocabulary", play_time: 180, score: 5, description: File.read(Rails.root + 'db/data/spanish/descriptions/countries.md'))

puts "game created"
puts "parsing json"

countries_data_es = JSON.parse(File.read(Rails.root + 'db/data/spanish/countries.json'))

puts "parsed"
puts "populating game with problems..."

countries_data_es.each do |problem_data|
  problem = Problem.find_or_create_by!(game: countries_es, question: problem_data["question"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["kanji"], character_type: "kanji")
  Answer.find_or_create_by!(problem: problem, data: problem_data["kana"], character_type: "kana")
  Answer.find_or_create_by!(problem: problem, data: problem_data["romaji"], character_type: "romaji")
end

puts "job done"
puts "countries is ready"

puts "次"

puts "creating emotions and feelings"

emotions_and_feelings_es = Game.find_or_create_by(name: "emociones y sentimientos", icon_based: true, question_header: "la pregunta", language: spanish, genre: "table_game", difficulty: "advanced", category: "vocabulary", play_time: 180, score: 5, description: File.read(Rails.root + 'db/data/spanish/descriptions/emotions_and_feelings.md'))

puts "game created"
puts "parsing json"

emotions_and_feelings_data_es = JSON.parse(File.read(Rails.root + 'db/data/spanish/emotions_and_feelings.json'))

puts "parsed"
puts "populating game with problems..."

emotions_and_feelings_data_es.each do |problem_data|
  problem = Problem.find_or_create_by!(game: emotions_and_feelings_es, question: problem_data["question"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["kanji"], character_type: "kanji")
  Answer.find_or_create_by!(problem: problem, data: problem_data["kana"], character_type: "kana")
  Answer.find_or_create_by!(problem: problem, data: problem_data["romaji"], character_type: "romaji")
end

puts "job done"
puts "emotions and feelings is ready"

puts "次"

puts "creating food"

food_es = Game.find_or_create_by(name: "la comida", icon_based: true, question_header: "la pregunta", language: spanish, genre: "table_game", difficulty: "intermediate", category: "vocabulary", play_time: 180, score: 5, description: File.read(Rails.root + 'db/data/spanish/descriptions/food.md'))

puts "game created"
puts "parsing json"

food_data_es = JSON.parse(File.read(Rails.root + 'db/data/spanish/food.json'))

puts "parsed"
puts "populating game with problems..."

food_data_es.each do |problem_data|
  problem = Problem.find_or_create_by!(game: food_es, question: problem_data["question"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["kanji"], character_type: "kanji")
  Answer.find_or_create_by!(problem: problem, data: problem_data["kana"], character_type: "kana")
  Answer.find_or_create_by!(problem: problem, data: problem_data["romaji"], character_type: "romaji")
end

puts "job done"
puts "food is ready"

puts "次"

puts "creating nature and weather"

nature_and_weather_es = Game.find_or_create_by(name: "naturaleza y clima", icon_based: true, question_header: "la pregunta", language: spanish, genre: "table_game", difficulty: "intermediate", category: "vocabulary", play_time: 180, score: 5, description: File.read(Rails.root + 'db/data/spanish/descriptions/nature_and_weather.md'))

puts "game created"
puts "parsing json"

nature_and_weather_data_es = JSON.parse(File.read(Rails.root + 'db/data/spanish/nature_and_weather.json'))

puts "parsed"
puts "populating game with problems..."

nature_and_weather_data_es.each do |problem_data|
  problem = Problem.find_or_create_by!(game: nature_and_weather_es, question: problem_data["question"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["kanji"], character_type: "kanji")
  Answer.find_or_create_by!(problem: problem, data: problem_data["kana"], character_type: "kana")
  Answer.find_or_create_by!(problem: problem, data: problem_data["romaji"], character_type: "romaji")
end

puts "job done"
puts "nature and weather is ready"

puts "次"

puts "creating people and jobs"

people_and_jobs_es = Game.find_or_create_by(name: "personas y trabajos", icon_based: true, question_header: "la pregunta", language: spanish, genre: "table_game", difficulty: "intermediate", category: "vocabulary", play_time: 180, score: 5, description: File.read(Rails.root + 'db/data/spanish/descriptions/people_and_jobs.md'))

puts "game created"
puts "parsing json"

people_and_jobs_data_es = JSON.parse(File.read(Rails.root + 'db/data/spanish/people_and_jobs.json'))

puts "parsed"
puts "populating game with problems..."

people_and_jobs_data_es.each do |problem_data|
  problem = Problem.find_or_create_by!(game: people_and_jobs_es, question: problem_data["question"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["kanji"], character_type: "kanji")
  Answer.find_or_create_by!(problem: problem, data: problem_data["kana"], character_type: "kana")
  Answer.find_or_create_by!(problem: problem, data: problem_data["romaji"], character_type: "romaji")
end

puts "job done"
puts "people and jobs is ready"

puts "次"

puts "creating sports and activities"

sports_and_activites_es = Game.find_or_create_by(name: "deportes y actividades", icon_based: true, question_header: "la pregunta", language: spanish, genre: "table_game", difficulty: "intermediate", category: "vocabulary", play_time: 180, score: 5, description: File.read(Rails.root + 'db/data/spanish/descriptions/sports_and_activities.md'))

puts "game created"
puts "parsing json"

sports_and_activites_data_es = JSON.parse(File.read(Rails.root + 'db/data/spanish/sports_and_activites.json'))

puts "parsed"
puts "populating game with problems..."

sports_and_activites_data_es.each do |problem_data|
  problem = Problem.find_or_create_by!(game: sports_and_activites_es, question: problem_data["question"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["kanji"], character_type: "kanji")
  Answer.find_or_create_by!(problem: problem, data: problem_data["kana"], character_type: "kana")
  Answer.find_or_create_by!(problem: problem, data: problem_data["romaji"], character_type: "romaji")
end

puts "job done"
puts "sports and activities is ready"

puts "次"

puts "creating tech and tools"

tech_and_tools_es = Game.find_or_create_by(name: "tecnología y herramientas", icon_based: true, question_header: "la pregunta", language: spanish, genre: "table_game", difficulty: "intermediate", category: "vocabulary", play_time: 180, score: 5, description: File.read(Rails.root + 'db/data/spanish/descriptions/tech_and_tools.md'))

puts "game created"
puts "parsing json"

tech_and_tools_data_es = JSON.parse(File.read(Rails.root + 'db/data/spanish/tech_and_tools.json'))

puts "parsed"
puts "populating game with problems..."

tech_and_tools_data_es.each do |problem_data|
  problem = Problem.find_or_create_by!(game: tech_and_tools_es, question: problem_data["question"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["kanji"], character_type: "kanji")
  Answer.find_or_create_by!(problem: problem, data: problem_data["kana"], character_type: "kana")
  Answer.find_or_create_by!(problem: problem, data: problem_data["romaji"], character_type: "romaji")
end

puts "job done"
puts "tech and tools is ready"

puts "次"

puts "creating travel and places"

travel_and_places_es = Game.find_or_create_by(name: "viajes y lugares", icon_based: true, question_header: "la pregunta", language: spanish, genre: "table_game", difficulty: "intermediate", category: "vocabulary", play_time: 180, score: 5, description: File.read(Rails.root + 'db/data/spanish/descriptions/travel_and_places.md'))

puts "game created"
puts "parsing json"

travel_and_places_data_es = JSON.parse(File.read(Rails.root + 'db/data/spanish/travel_and_places.json'))

puts "parsed"
puts "populating game with problems..."

travel_and_places_data_es.each do |problem_data|
  problem = Problem.find_or_create_by!(game: travel_and_places_es, question: problem_data["question"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["kanji"], character_type: "kanji")
  Answer.find_or_create_by!(problem: problem, data: problem_data["kana"], character_type: "kana")
  Answer.find_or_create_by!(problem: problem, data: problem_data["romaji"], character_type: "romaji")
end

puts "job done"
puts "travel and places is ready"

puts "spanish finished"

puts "おわり"

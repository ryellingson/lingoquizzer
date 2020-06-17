# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'json'

Language.destroy_all

usernames = ["test1", "test2", "test3", "test4", "test5", "test6", "test7", "test8", "test9", "test10", "test11", "test12", "test13", "test14", "test15",]

usernames.each do |username|
  User.create(username: username, email: "#{username}#{'@example.com'}", password: "#{username}#{'pass'}", password_confirmation: "#{username}#{'pass'}")
end

User.create(username: "admin1", email: "admin1@go.com", password: "admin1pass", password_confirmation: "admin1pass", admin: true)

language_names = { ja: "japanese", es: "spanish", en: "english", fr: "french" }

language_names.each do |code, language|
  Language.create(language_code: code, name: language)
end

japanese = Language.find_by(name: "japanese")

table_games = Genre.create(name: "table games")

difficulty_levels = ["beginner", "intermediate", "advanced"]

difficulty_levels.each do |level|
  Difficulty.create(level: level)
end

beginner = Difficulty.find_by(level: "beginner")

intermediate = Difficulty.find_by(level: "intermediate")

advanced = Difficulty.find_by(level: "advanced")

category_types = ["typing", "vocabulary", "grammar"]

category_types.each do |type|
  Category.create(name: type)
end

typing = Category.find_by(name: "typing")

vocabulary = Category.find_by(name: "vocabulary")

grammar = Category.find_by(name: "grammar")

puts "おはよう"

puts "checking to see if Hiragana 1 exists, if not creating it"

hiragana_1 = Game.find_or_create_by(name: "Hiragana 1", question_header: "Hiragana", language: japanese, genre: table_games, difficulty: beginner, category: typing)

# if found?

puts "game created"
puts "parsing hiragana_1 json"

hiragana_1_data = JSON.parse(File.read(Rails.root + 'db/data/hiragana_1.json'))

puts "parsed"
puts "populating game with problems..."

hiragana_1 = Game.find_by(name: "Hiragana 1")

hiragana_1_data.each do |problem_data|
  problem = Problem.find_or_create_by!(game: hiragana_1, question: problem_data["character"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["romanization"])
end

puts "job done"
puts "Hiragana 1 is ready よしよし"

puts "次"

puts "checking to see if Hiragana 2 exists, if not creating it"

hiragana_2 = Game.find_or_create_by(name: "Hiragana 2", question_header: "Hiragana", language: japanese, genre: table_games, difficulty: intermediate, category: typing)

# if found?

puts "game created"
puts "parsing hiragana_2 json"

hiragana_2_data = JSON.parse(File.read(Rails.root + 'db/data/hiragana_2.json'))

puts "parsed"
puts "populating game with problems..."

hiragana_2_data.each do |problem_data|
 problem = Problem.find_or_create_by!(game: hiragana_2, question: problem_data["character"])
 Answer.find_or_create_by!(problem: problem, data: problem_data["romanization"])
end

puts "job done"
puts "Hiragana 2 is ready よしししししし"

puts "次"

puts "checking to see if Ultimate Hiragana exists, if not creating it"

ultimate_hiragana = Game.find_or_create_by(name: "Ultimate Hiragana", question_header: "Hiragana", language: japanese, genre: table_games, difficulty: advanced, category: typing)

# if found?

puts "game created"
puts "parsing ultimate_hiragana json"

ultimate_hiragana_data = JSON.parse(File.read(Rails.root + 'db/data/ultimate_hiragana.json'))

puts "parsed"
puts "populating game with problems..."

ultimate_hiragana_data.each do |problem_data|
  problem = Problem.find_or_create_by!(game: ultimate_hiragana, question: problem_data["character"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["romanization"])
end

puts "job done"
puts "Ultimate Hiragana is ready すごい！"

puts "次"

puts "ヘロ"

puts "checking to see if Katakana 1 exists, if not creating it"

katakana_1 = Game.find_or_create_by(name: "Katakana 1", question_header: "Katakana", language: japanese, genre: table_games, difficulty: beginner, category: typing)

puts "game created"
puts "parsing katakana json"

katakana_1_data = JSON.parse(File.read(Rails.root + 'db/data/katakana_1.json'))

puts "parsed"
puts "populating game with problems..."

katakana_1_data.each do |problem_data|
  problem = Problem.find_or_create_by!(game: katakana_1, question: problem_data["character"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["romanization"])
end

puts "job done"
puts "Katakana 1 is ready レズゴ"

puts "次"

puts "checking to see if Katakana 2 exists, if not creating it"

katakana_2 = Game.find_or_create_by(name: "Katakana 2", question_header: "Katakana", language: japanese, genre: table_games, difficulty: intermediate, category: typing)

puts "game created"
puts "parsing katakana_2 json"

katakana_2_data = JSON.parse(File.read(Rails.root + 'db/data/katakana_2.json'))

puts "parsed"
puts "populating game with problems..."

katakana_2_data.each do |problem_data|
 problem = Problem.find_or_create_by!(game: katakana_2, question: problem_data["character"])
 Answer.find_or_create_by!(problem: problem, data: problem_data["romanization"])
end

puts "job done"
puts "Katakana 2 is ready ネクストレベル"

puts "次"

puts "checking to see if Ultimate Katakana exists, if not creating it"

ultimate_katakana = Game.find_or_create_by(name: "Ultimate Katakana", question_header: "Katakana", language: japanese, genre: table_games, difficulty: advanced, category: typing)

puts "game created"
puts "parsing utimate_katakana json"

ultimate_katakana_data = JSON.parse(File.read(Rails.root + 'db/data/ultimate_katakana.json'))

puts "parsed"
puts "populating game with problems..."

ultimate_katakana_data.each do |problem_data|
  problem = Problem.find_or_create_by!(game: ultimate_katakana, question: problem_data["character"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["romanization"])
end

puts "job done"
puts "Ultimate Katakana is ready アルティメート"

puts "次"

# puts "checking to see if Kana vs Kana 1 exists, if not creating it"

# kana_vs_kana_1 = Game.find_or_create_by(name: "Kana vs Kana 1")

# puts "game created"
# puts "parsing kana_vs_kana_1 json"

# kana_vs_kana_1_data = JSON.parse(File.read(Rails.root + 'db/data/kana_vs_kana_1.json'))

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

animals = Game.find_or_create_by(name: "Animals", icon_based: true, question_header: "Animal", language: japanese, genre: table_games, difficulty: intermediate, category: vocabulary)

puts "game created"
puts "parsing json"

animals_data = JSON.parse(File.read(Rails.root + 'db/data/animals.json'))

puts "parsed"
puts "populating game with problems..."

animals_data.each do |problem_data|
  problem = Problem.find_or_create_by!(game: animals, question: problem_data["problem_icon"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["romanization"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["kana"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["kanji"])
end

puts "job done"
puts "Animals is ready にゃんにゃん"

puts "次"

puts "creating around the house"

around_the_house = Game.find_or_create_by(name: "Around the house", icon_based: true, question_header: "Question", language: japanese, genre: table_games, difficulty: intermediate, category: vocabulary)

puts "game created"
puts "parsing json"

around_the_house_data = JSON.parse(File.read(Rails.root + 'db/data/around_the_house.json'))

puts "parsed"
puts "populating game with problems..."

around_the_house_data.each do |problem_data|
  problem = Problem.find_or_create_by!(game: around_the_house, question: problem_data["question"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["romaji"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["kana"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["kanji"])
end

puts "job done"
puts "around the house is ready"

puts "次"

puts "creating countries"

countries = Game.find_or_create_by(name: "Countries", icon_based: true, question_header: "Country", language: japanese, genre: table_games, difficulty: intermediate, category: vocabulary)

puts "game created"
puts "parsing json"

countries_data = JSON.parse(File.read(Rails.root + 'db/data/countries.json'))

puts "parsed"
puts "populating game with problems..."

countries_data.each do |problem_data|
  problem = Problem.find_or_create_by!(game: countries, question: problem_data["question"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["romaji"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["kana"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["kanji"])
end

puts "job done"
puts "countries is ready"

puts "次"

puts "creating emotions and feelings"

emotions_and_feelings = Game.find_or_create_by(name: "Emotions and Feelings", icon_based: true, question_header: "Emotion", language: japanese, genre: table_games, difficulty: intermediate, category: vocabulary)

puts "game created"
puts "parsing json"

emotions_and_feelings_data = JSON.parse(File.read(Rails.root + 'db/data/emotions_and_feelings.json'))

puts "parsed"
puts "populating game with problems..."

emotions_and_feelings_data.each do |problem_data|
  problem = Problem.find_or_create_by!(game: emotions_and_feelings, question: problem_data["question"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["romaji"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["kana"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["kanji"])
end

puts "job done"
puts "emotions and feelings is ready"

puts "次"

puts "creating food"

food = Game.find_or_create_by(name: "Food", icon_based: true, question_header: "Food", language: japanese, genre: table_games, difficulty: intermediate, category: vocabulary)

puts "game created"
puts "parsing json"

food_data = JSON.parse(File.read(Rails.root + 'db/data/food.json'))

puts "parsed"
puts "populating game with problems..."

food_data.each do |problem_data|
  problem = Problem.find_or_create_by!(game: food, question: problem_data["question"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["romaji"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["kana"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["kanji"])
end

puts "job done"
puts "emotions and feelings is ready"

puts "次"

puts "creating nature and weather"

nature_and_weather = Game.find_or_create_by(name: "Nature and Weather", icon_based: true, question_header: "Question", language: japanese, genre: table_games, difficulty: intermediate, category: vocabulary)

puts "game created"
puts "parsing json"

nature_and_weather_data = JSON.parse(File.read(Rails.root + 'db/data/nature_and_weather.json'))

puts "parsed"
puts "populating game with problems..."

nature_and_weather_data.each do |problem_data|
  problem = Problem.find_or_create_by!(game: nature_and_weather, question: problem_data["question"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["romaji"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["kana"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["kanji"])
end

puts "job done"
puts "nature and weather is ready"

puts "次"

puts "creating people and jobs"

people_and_jobs = Game.find_or_create_by(name: "People and Jobs", icon_based: true, question_header: "Question", language: japanese, genre: table_games, difficulty: intermediate, category: vocabulary)

puts "game created"
puts "parsing json"

people_and_jobs_data = JSON.parse(File.read(Rails.root + 'db/data/people_and_jobs.json'))

puts "parsed"
puts "populating game with problems..."

people_and_jobs_data.each do |problem_data|
  problem = Problem.find_or_create_by!(game: people_and_jobs, question: problem_data["question"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["romaji"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["kana"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["kanji"])
end

puts "job done"
puts "people and jobs is ready"

puts "次"

puts "creating sports and activities"

sports_and_activites = Game.find_or_create_by(name: "Sports and Activities", icon_based: true, question_header: "Question", language: japanese, genre: table_games, difficulty: intermediate, category: vocabulary)

puts "game created"
puts "parsing json"

sports_and_activites_data = JSON.parse(File.read(Rails.root + 'db/data/sports_and_activites.json'))

puts "parsed"
puts "populating game with problems..."

sports_and_activites_data.each do |problem_data|
  problem = Problem.find_or_create_by!(game: sports_and_activites, question: problem_data["question"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["romaji"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["kana"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["kanji"])
end

puts "job done"
puts "sports and activities is ready"

puts "次"

puts "creating tech and tools"

tech_and_tools = Game.find_or_create_by(name: "Tech and Tools", icon_based: true, question_header: "Question", language: japanese, genre: table_games, difficulty: intermediate, category: vocabulary)

puts "game created"
puts "parsing json"

tech_and_tools_data = JSON.parse(File.read(Rails.root + 'db/data/tech_and_tools.json'))

puts "parsed"
puts "populating game with problems..."

tech_and_tools_data.each do |problem_data|
  problem = Problem.find_or_create_by!(game: tech_and_tools, question: problem_data["question"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["romaji"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["kana"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["kanji"])
end

puts "job done"
puts "tech and tools is ready"

puts "次"

puts "creating travel and places"

travel_and_places = Game.find_or_create_by(name: "Travel and Places", icon_based: true, question_header: "Question", language: japanese, genre: table_games, difficulty: intermediate, category: vocabulary)

puts "game created"
puts "parsing json"

travel_and_places_data = JSON.parse(File.read(Rails.root + 'db/data/travel_and_places.json'))

puts "parsed"
puts "populating game with problems..."

travel_and_places_data.each do |problem_data|
  problem = Problem.find_or_create_by!(game: travel_and_places, question: problem_data["question"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["romaji"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["kana"])
  Answer.find_or_create_by!(problem: problem, data: problem_data["kanji"])
end

puts "job done"
puts "travel and places is ready"

puts "おわり"

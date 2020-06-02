# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'json'

language_names = ["japanese", "spanish", "english", "french"]

language_names.each do |language|
  Language.create(name: language)
end

table_games = Genre.create(name: "table games")

difficulty_levels = ["beginner", "intermediate", "advanced"]

difficulty_levels.each do |level|
  Difficulty.create(level: level)
end

category_types = ["typing", "vocabulary", "grammar"]

category_types.each do |type|
  Category.create(name: type)
end

puts "おはよう"

puts "checking to see if Hiragana 1 exists, if not creating it"

hiragana_1 = Game.find_or_create_by(name: "Hiragana 1", question_header: "Hiragana", language: "japanese" genre: table_games, difficulty: "beginner", category: "typing")

# if found?

puts "game created"
puts "parsing hiragana_1 json"

hiragana_1_data = JSON.parse(File.read(Rails.root + 'db/data/hiragana_1.json'))

puts "parsed"
puts "populating game with problems..."

hiragana_1_data.each do |problem_data|
  Problem.find_or_create_by!(game: hiragana_1, question: problem_data["character"], answer: problem_data["romanization"])
end

puts "job done"
puts "Hiragana 1 is ready よしよし"

puts "次"

puts "checking to see if Hiragana 2 exists, if not creating it"

hiragana_2 = Game.find_or_create_by(name: "Hiragana 2", question_header: "Hiragana", language: "japanese" genre: table_games, difficulty: "intermediate", category: "typing")

# if found?

puts "game created"
puts "parsing hiragana_2 json"

hiragana_2_data = JSON.parse(File.read(Rails.root + 'db/data/hiragana_2.json'))

puts "parsed"
puts "populating game with problems..."

hiragana_2_data.each do |problem_data|
  Problem.find_or_create_by!(game: hiragana_2, question: problem_data["character"], answer: problem_data["romanization"])
end

puts "job done"
puts "Hiragana 2 is ready よしししししし"

puts "次"

puts "checking to see if Ultimate Hiragana exists, if not creating it"

ultimate_hiragana = Game.find_or_create_by(name: "Ultimate Hiragana", question_header: "Hiragana", language: "japanese" genre: table_games, difficulty: "advanced", category: "typing")

# if found?

puts "game created"
puts "parsing ultimate_hiragana json"

ultimate_hiragana_data = JSON.parse(File.read(Rails.root + 'db/data/ultimate_hiragana.json'))

puts "parsed"
puts "populating game with problems..."

ultimate_hiragana_data.each do |problem_data|
  Problem.find_or_create_by!(game: ultimate_hiragana, question: problem_data["character"], answer: problem_data["romanization"])
end

puts "job done"
puts "Ultimate Hiragana is ready すごい！"

puts "次"

puts "ヘロ"

puts "checking to see if Katakana 1 exists, if not creating it"

katakana_1 = Game.find_or_create_by(name: "Katakana 1", question_header: "Katakana", language: "japanese" genre: table_games, difficulty: "beginner", category: "typing")

puts "game created"
puts "parsing katakana json"

katakana_1_data = JSON.parse(File.read(Rails.root + 'db/data/katakana_1.json'))

puts "parsed"
puts "populating game with problems..."

katakana_1_data.each do |problem_data|
  Problem.find_or_create_by!(game: katakana_1, question: problem_data["character"], answer: problem_data["romanization"])
end

puts "job done"
puts "Katakana 1 is ready レズゴ"

puts "次"

puts "checking to see if Katakana 2 exists, if not creating it"

katakana_2 = Game.find_or_create_by(name: "Katakana 2", question_header: "Katakana", language: "japanese" genre: table_games, difficulty: "intermediate", category: "typing")

puts "game created"
puts "parsing katakana_2 json"

katakana_2_data = JSON.parse(File.read(Rails.root + 'db/data/katakana_2.json'))

puts "parsed"
puts "populating game with problems..."

katakana_2_data.each do |problem_data|
  Problem.find_or_create_by!(game: katakana_2, question: problem_data["character"], answer: problem_data["romanization"])
end

puts "job done"
puts "Katakana 2 is ready ネクストレベル"

puts "次"

puts "checking to see if Ultimate Katakana exists, if not creating it"

ultimate_katakana = Game.find_or_create_by(name: "Ultimate Katakana", question_header: "Katakana", language: "japanese" genre: table_games, difficulty: "advanced", category: "typing")

puts "game created"
puts "parsing utimate_katakana json"

ultimate_katakana_data = JSON.parse(File.read(Rails.root + 'db/data/ultimate_katakana.json'))

puts "parsed"
puts "populating game with problems..."

ultimate_katakana_data.each do |problem_data|
  Problem.find_or_create_by!(game: ultimate_katakana, question: problem_data["character"], answer: problem_data["romanization"])
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

puts "checking to see if Animals exists, if not creating it"

animals = Game.find_or_create_by(name: "Animals", icon_based: true, question_header: "Animal", language: "japanese" genre: table_games, difficulty: "intermediate", category: "typing")

puts "game created"
puts "parsing animals json"

animals_data = JSON.parse(File.read(Rails.root + 'db/data/animals.json'))

puts "parsed"
puts "populating game with problems..."

animals_data.each do |problem_data|
  Problem.find_or_create_by!(game: animals, question: problem_data["problem_icon"], answer: problem_data["romanization"])
end

puts "job done"
puts "Animals is ready にゃんにゃん"





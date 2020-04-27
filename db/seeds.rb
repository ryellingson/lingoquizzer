# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'json'

puts "おはよう"

puts "done"
puts "checking to see if Hiragana 1 exists, if not creating it"

hiragana_1 = Game.find_or_create_by(name: "Hiragana 1")

puts "game created"
puts "parsing hiragana json"

hiragana_data = JSON.parse(File.read(Rails.root + 'db/data/hiragana.json'))

puts "parsed"
puts "populating game with problems..."

hiragana_data.each do |problem_data|
  Problem.find_or_create_by!(game: hiragana_1, question: problem_data["character"], answer: problem_data["romanization"])
end

puts "job done"
puts "Hiragana 1 is ready よしよし"


puts "ヘロ"
puts "checking to see if Katakana 1 exists, if not creating it"

katakana_1 = Game.find_or_create_by(name: "Katakana 1")

puts "game created"
puts "parsing katakana json"

katakana_data = JSON.parse(File.read(Rails.root + 'db/data/katakana.json'))

puts "parsed"
puts "populating game with problems..."

katakana_data.each do |problem_data|
  Problem.find_or_create_by!(game: katakana_1, question: problem_data["character"], answer: problem_data["romanization"])
end

puts "job done"
puts "Katakana 1 is ready レズゴ"


# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'json'

puts "おはよう"
puts "destroying game data..."

Game.destroy_all

puts "done"
puts "creating Hiragana Sprint"

hiragana_sprint = Game.create(name: "Hiragana Sprint")

puts "game created"
puts "parsing hiragana json"

hiragana_data = JSON.parse(File.read(Rails.root + 'db/data/hiragana.json'))

puts "parsed"
puts "populating game with problems..."

hiragana_data.each do |problem_data|
  Problem.create!(game: hiragana_sprint, question: problem_data["character"], answer: problem_data["romanization"])
end

puts "job done"
puts "Hiragana Sprint is ready よしよし"

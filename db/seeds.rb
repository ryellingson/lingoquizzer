# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'json'

Game.destroy_all

hiragana_sprint = Game.create(name: "Hiragana Sprint")

hiragana_data = JSON.parse(File.read(Rails.root + 'db/data/hiragana.json'))

hiragana_data.each do |problem_data|
  Problem.create!(game: hiragana_sprint, question: problem_data["character"], answer: problem_data["romanization"])
end

puts "job done"

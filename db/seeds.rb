# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:

require 'json'

# puts "destroying previous data"

# puts "Language"
# Language.destroy_all

# puts "Game"
# Game.destroy_all

# puts "User"
# User.destroy_all

# puts "Comment"
# Comment.destroy_all

# puts "Post"
# Post.destroy_all

# puts "generating users"

# usernames = ["Ry", "Trouni", "test1", "test2", "test3", "test4", "test5", "test6", "test7", "test8", "test9", "test10", "test11", "test12", "test13", "test14", "test15"]

# usernames.each do |username|
#   user = User.find_or_initialize_by(username: username, email: "#{username}#{'@example.com'}")
#   user.password = "#{username}#{'pass'}"
#   user.save
# end

# admin = User.find_or_initialize_by(username: "admin1", email: "admin1@go.com", admin: true)
# admin.password = "admin1pass"
# admin.save

# puts "generating posts"

# 100.times do
#   post = Post.new(title: Faker::ChuckNorris.fact, language: Language.all.sample, user: User.all.sample)
#   post.content = Faker::Lorem.paragraphs(number: rand(1...5)).join
#   post.save
# end
# "table_game" = Genre.find_or_create_by(name: "table_game games")

# puts "creating plays"

# 500.times do
#   game = Game.all.sample
#   Play.find_or_create_by(score: game.score * rand(game.problems.count), time: rand(game.play_time), user: User.all.sample, game: game, count: rand(game.problems.count))
# end

puts "おわり"

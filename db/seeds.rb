# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:

require 'json'

KANA_GAMES_HASH = [
  { name: "Hiragana 1", question_header: "Hiragana", genre: "table_game", difficulty: "beginner", category: "reading", character_type: "kana", play_time: 120, score: 2, slug: 'hiragana_1', unlock_cp: 0},
  { name: "Hiragana 2", question_header: "Hiragana", genre: "table_game", difficulty: "intermediate", category: "reading", character_type: "kana", play_time: 180, score: 2, slug: 'hiragana_2', unlock_cp: 3},
  { name: "Ultimate Hiragana", question_header: "Hiragana", genre: "table_game", difficulty: "advanced", category: "reading", character_type: "kana", play_time: 240, score: 2, slug: 'ultimate_hiragana', unlock_cp: 7},
  { name: "Katakana 1", question_header: "Katakana", genre: "table_game", difficulty: "beginner", category: "reading", character_type: "kana", play_time: 120, score: 2, slug: 'katakana_1', unlock_cp: 0},
  { name: "Katakana 2", question_header: "Katakana", genre: "table_game", difficulty: "intermediate", category: "reading", character_type: "kana", play_time: 180, score: 2, slug: 'katakana_2', unlock_cp: 3},
  { name: "Ultimate Katakana", question_header: "Katakana", genre: "table_game", difficulty: "advanced", category: "reading", character_type: "kana", play_time: 240, score: 2, slug: 'ultimate_katakana', unlock_cp: 7},
]

GAMES_HASH = [
  { name: "Animals", icon_based: true, question_header: "Animal", genre: "table_game", difficulty: "intermediate", category: "vocabulary", play_time: 180, score: 5, slug: 'animals', unlock_cp: 15},
  { name: "Around the House", icon_based: true, question_header: "Question", genre: "table_game", difficulty: "intermediate", category: "vocabulary", play_time: 180, score: 5, slug: 'around_the_house', unlock_cp: 15},
  { name: "Countries", icon_based: true, question_header: "Country", genre: "table_game", difficulty: "advanced", category: "vocabulary", play_time: 180, score: 5, slug: 'countries', unlock_cp: 15},
  { name: "Emotions and Feelings", icon_based: true, question_header: "Question", genre: "table_game", difficulty: "advanced", category: "vocabulary", play_time: 180, score: 5, slug: 'emotions_and_feelings', unlock_cp: 15},
  { name: "Food", icon_based: true, question_header: "Food", genre: "table_game", difficulty: "intermediate", category: "vocabulary", play_time: 180, score: 5, slug: 'food', unlock_cp: 15},
  { name: "Nature and Weather", icon_based: true, question_header: "Question", genre: "table_game", difficulty: "intermediate", category: "vocabulary", play_time: 180, score: 5, slug: 'nature_and_weather', unlock_cp: 15},
  { name: "People and Jobs", icon_based: true, question_header: "Question", genre: "table_game", difficulty: "intermediate", category: "vocabulary", play_time: 180, score: 5, slug: 'people_and_jobs', unlock_cp: 15},
  { name: "Sports and Activities", icon_based: true, question_header: "Question", genre: "table_game", difficulty: "intermediate", category: "vocabulary", play_time: 180, score: 5, slug: 'sports_and_activities', unlock_cp: 15},
  { name: "Tech and Tools", icon_based: true, question_header: "Question", genre: "table_game", difficulty: "intermediate", category: "vocabulary", play_time: 180, score: 5, slug: 'tech_and_tools', unlock_cp: 15},
  { name: "Travel and Places", icon_based: true, question_header: "Question", genre: "table_game", difficulty: "intermediate", category: "vocabulary", play_time: 180, score: 5, slug: 'travel_and_places', unlock_cp: 15}
]

NUMBER_GUESS_HASH = [
  {name: "Guess the Number", icon_based: false, question_header: nil, genre: "number_guess", difficulty: "beginner", category: "numbers", play_time:60, score: 50, slug: "number_guess", unlock_cp: 5}
]


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

puts "generating languages"

languages_array = [
  {language_code: 'ja', name: 'japanese', video_url: "https://www.youtube.com/embed/45vSd2dLaQU"},
  {language_code: 'en', name: 'english', video_url: "https://www.youtube.com/embed/B1ed-pfqdZg"},
  {language_code: 'es', name: 'spanish', video_url: "https://www.youtube.com/embed/lO9X-7beRa8"},
  {language_code: 'fr', name: 'french', video_url: "https://www.youtube.com/embed/ujDtm0hZyII"}
]

languages_array.each { |language| Language.find_or_create_by(language) }


puts "おはよう"

def game_builder(lang, game_attr)

  game = Game.find_or_initialize_by(name: game_attr[:name], language: lang)
  if game.persisted? && !ENV["force"]
    puts "#{game.name} already exists, skipping it"
  else
    puts "parsing JSON"
    json_file_path = Rails.root + "db/data/#{lang.name}/#{game_attr[:slug]}.json"
    return unless File.exist?(json_file_path)

    game_data = JSON.parse(File.read(json_file_path))
    puts "parsed"

    puts "adding description"
    md_file_path = Rails.root + "db/data/#{lang.name}/descriptions/#{game_attr[:slug]}.md"
    game_attr[:description] = File.read(md_file_path) if File.exist?(md_file_path)
    puts "making #{game_attr[:name]} and setting language"

    puts game_attr

    game.update(**game_attr, language: lang, authors: [{
      name: 'Ry',
      url: 'https://github.com/ryellingson',
    }, {
      name: 'Trouni',
      url: 'https://github.com/trouni/'
    }])
    puts "created #{game.language.name}: #{game.name}"

    if game.table_game?
      puts "populating game with problems..."
      if game_data.first.keys.include?("kanji")
        game_data.each do |problem_data|
          problem = Problem.find_or_create_by!(game: game, question: problem_data["question"])
          Answer.find_or_create_by!(problem: problem, data: problem_data["kanji"], character_type: "kanji")
          Answer.find_or_create_by!(problem: problem, data: problem_data["kana"], character_type: "kana")
          Answer.find_or_create_by!(problem: problem, data: problem_data["romaji"], character_type: "romaji")
        end
      elsif game_data.first.keys.include?("romanization")
        game_data.each do |problem_data|
          problem = Problem.find_or_create_by!(game: game, question: problem_data["character"])
          answer = Answer.find_or_create_by!(problem: problem, data: problem_data["romanization"], character_type: "romaji")
        end
      else
        game_data.each do |problem_data|
          problem = Problem.find_or_create_by!(game: game, question: problem_data["question"])
          answer = Answer.find_or_create_by!(problem: problem, data: problem_data["answer"], character_type: "latin")
        end
      end
    end
  end
end

KANA_GAMES_HASH.each do |game_attr|
  japanese = Language.find_by(name: "japanese")
  game_builder(japanese, game_attr)
end


Language.all.each do |lang|
  GAMES_HASH.each do |game_attr|
    game_builder(lang, game_attr)
  end
  NUMBER_GUESS_HASH.each do |game_attr|
    game_builder(lang, game_attr)
  end
end

puts "done with games"

# puts "creating plays"

# 500.times do
#   game = Game.all.sample
#   Play.find_or_create_by(score: game.score * rand(game.problems.count), time: rand(game.play_time), user: User.all.sample, game: game, count: rand(game.problems.count))
# end

puts "おわり"

class Game < ApplicationRecord
  validates :name, uniqueness: { scope: :language }
  has_many :problems, dependent: :destroy
  has_many :answers, through: :problems
  has_many :plays, dependent: :destroy
  belongs_to :language
  enum genre: { table_game: 0, number_guess: 3, classic_quiz: 4 }   # chart: 1, picture_click: 2 in the future
  enum category: { reading: 0, vocabulary: 1, grammar: 2, numbers: 3 }
  enum difficulty: { beginner: 0, intermediate: 1, advanced: 2 }
  enum character_type: { kana: 0, kanji: 1, romaji: 2 }
  before_save :assign_markdown_content, if: -> { description_changed? }

  # this defines the number of quesitons per game
  def problem_count
    if icon_based
      30
    elsif genre == "classic_quiz"
      2
    else
      problems.count
    end
  end

  def top_users
    sql = <<-SQL
    SELECT sum(plays.score) as score, users.* FROM plays
    JOIN users ON users.id = plays.user_id
    WHERE game_id = #{id}
    GROUP BY users.id
    ORDER BY score DESC
    LIMIT 10;
    SQL
    User.find_by_sql(sql)
  end

  class << self
    def markdown
      Redcarpet::Markdown.new(Redcarpet::Render::HTML, tables: true)
    end
  end

  def assign_markdown_content
    assign_attributes({
      markdown_content: self.class.markdown.render(description)
    })
  end
end

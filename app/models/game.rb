class Game < ApplicationRecord
  validates :name, uniqueness: :true
  has_many :problems, dependent: :destroy
  has_many :answers, through: :problems
  has_many :plays, dependent: :destroy
  belongs_to :language
  enum genre: { table_game: 0, chart: 1, picture_click: 2 }
  enum category: { typing: 0, vocabulary: 1, grammar: 2 }
  enum difficulty: { beginner: 0, intermediate: 1, advanced: 2 }
  enum character_type: { kana: 0, kanji: 1, romaji: 2 }
  before_save :assign_markdown_content, if: -> { description_changed? }

  def top_users_specific
    sql = <<-SQL
    SELECT sum(plays.score) as specific_score, users.* FROM plays
    JOIN users ON users.id = plays.user_id
    JOIN games ON games.id = plays.game_id
    WHERE games.id = #{id}
    GROUP BY users.id
    ORDER BY specific_score DESC
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

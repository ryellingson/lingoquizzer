class Game < ApplicationRecord
  validates :name, uniqueness: :true
  has_many :problems, dependent: :destroy
  has_many :plays, dependent: :destroy

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
end

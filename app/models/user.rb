class User < ApplicationRecord
  has_merit

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  attr_writer :login
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable, authentication_keys: [:login]

  has_many :plays, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :badges_sashes, through: :sash

  validates :email, uniqueness: true
  validates :username, uniqueness: true, length: { in: 3..16 }
  validates :username, format: { without: /\s/, message: "must contain no spaces" }

  # Only allow letter, number, underscore and punctuation.
  validates_format_of :username, with: /[一-龠]+|[ぁ-ゔ]+|[ァ-ヴー]+|[a-zA-Z0-9]+|[ａ-ｚＡ-Ｚ０-９]+|[々〆〤]+/u, :multiline => true

  has_one_attached :avatar

  after_create :assign_default_avatar, unless: Proc.new { self.avatar.attached? }

  def assign_default_avatar
    default_avatars = JSON.parse(File.read(Rails.application.root + "db/data/japanese/hiragana_1.json"))
    self.update(default_avatar: default_avatars.sample["character"])
  end

  def display_plays
    self.plays.order(created_at: :desc).limit(50)
  end

  def best_plays
    self.plays.order(score: :desc).limit(25)
  end

  def best_score(game)
  end

  def login
    @login || self.username || self.email
  end

  def banned?
    banned
  end

  def self.top_users
    sql = <<-SQL
    SELECT users.*, SUM(score) as score
    FROM plays
    JOIN users ON users.id = plays.user_id
    GROUP BY users.id
    ORDER BY score DESC
    LIMIT 10
    SQL
    User.find_by_sql(sql)
  end

  def hint_points
    self.hint_points = self.convo_points / 10
  end

  def total_score
    plays.sum(&:score)
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

  def badges_to_display
    badges.any? ? badges : [Merit::Badge.all.find { |badge| badge.name == 'welcome' }]
  end
end

class Answer < ApplicationRecord
  belongs_to :problem
  enum character_type: { kanji: 0, kana: 1, romaji: 2 }
end

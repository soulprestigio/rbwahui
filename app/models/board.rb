class Board < ApplicationRecord
  serialize :synonyms, Array

  validates :board_number, presence: true, uniqueness: true
  validates :board_name, presence: true
end
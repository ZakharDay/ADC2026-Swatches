class Color < ApplicationRecord
  belongs_to :user
  has_many :fill_colors
  has_many :fills, through: :fill_colors

  # def as_json
  #   {
  #     rgb_hash: rgb_hash
  #   }
  # end
end

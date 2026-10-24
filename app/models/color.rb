class Color < ApplicationRecord
  belongs_to :user
  has_many :fill_colors
  has_many :fills, through: :fill_colors
end

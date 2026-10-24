class Fill < ApplicationRecord
  belongs_to :user
  belongs_to :swatch, optional: true
  has_many :fill_colors
  has_many :colors, through: :fill_colors
end

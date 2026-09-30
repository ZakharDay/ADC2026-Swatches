class Swatch < ApplicationRecord
  belongs_to :user
  belongs_to :project, optional: true
  has_many :fills, dependent: :destroy
end

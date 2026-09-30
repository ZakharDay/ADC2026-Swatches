class Fill < ApplicationRecord
  belongs_to :user
  belongs_to :swatch, optional: true
end

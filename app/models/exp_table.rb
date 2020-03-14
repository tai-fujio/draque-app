class ExpTable < ApplicationRecord
  validates :level, presence: true, uniqueness: true
  validates :exp, presence: true
end

class Monster < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :image, presence: true
  validates :bg_image, presence: true
  validates :exp, presence: true
  validates :recommended_level, presence: true
  validates :max_hp, presence: true
  validates :offense, presence: true
  validates :defense, presence: true
end

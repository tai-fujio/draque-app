class Brave < ApplicationRecord
  belongs_to :user
  
  validates :user_id, presence:true, uniqueness: true
  # uniqueness:一意性
  validates :name, presence: true, length: {maximum: 10}
  validates :exp, presence: true
  validates :level, presence: true
  validates :max_hp, presence: true
  validates :offense, presence: true
  validates :defense, presence: true



end

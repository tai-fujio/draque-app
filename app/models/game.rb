class Game < ApplicationRecord
  belongs_to :user

  validates :user_id, presence:true, uniqueness: true
  validates :spell, presence: true

  # attr_accessor :spell

  # def session_attributes
  #   attributes.slice("spell")
  # end
end

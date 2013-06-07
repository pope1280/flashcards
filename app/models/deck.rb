class Deck < ActiveRecord::Base
  belongs_to :user
  belongs_to :round
  has_many :cards
end

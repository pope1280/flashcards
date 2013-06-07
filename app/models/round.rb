class Round < ActiveRecord::Base
  belongs_to :user
  has_many :guesses
  has_one :deck
end

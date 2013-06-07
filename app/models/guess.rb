class Guess < ActiveRecord::Base
  belongs_to :round
  belongs_to :card

  def check_answer
    card = Card.find(self.card_id)
    if card.answer.downcase == self.user_answer.downcase
      self.result = "right"
      return true
    else
      self.result = "wrong"
      return false
    end
  end

  def 
end

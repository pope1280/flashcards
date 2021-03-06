class Guess < ActiveRecord::Base
  belongs_to :round
  belongs_to :card
  validates :user_answer, :presence => true

  def check_answer
    @card = Card.find(self.card_id)
    @deck = Deck.find(@card.deck_id)
    if @card.answer.downcase == self.user_answer.downcase
      self.result = "correct"
      self.save
    else
      self.result = "incorrect"
      self.save
    end
    @deck.get_next_card(@deck, @card)
  end
end

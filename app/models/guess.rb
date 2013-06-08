class Guess < ActiveRecord::Base
  belongs_to :round
  belongs_to :card

  def check_answer
    @card = Card.find(self.card_id)
    @deck = Deck.find(@card.deck_id)
    if @card.answer == self.user_answer
      self.result = "correct"
    else
      self.result = "incorrect"
    end
    @deck.get_next_card(@deck, @card)
  end
end

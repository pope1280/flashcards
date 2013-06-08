class Deck < ActiveRecord::Base
  belongs_to :user
  belongs_to :round
  has_many :cards


  def get_next_card(deck, card)
    card_index = deck.cards.index(card)
    response = {}
    if card_index == deck.cards.length - 1
      response[:round_status] = "over"
      response[:card] = nil
    else
      response[:round_status] = "in_process"
      response[:card] = deck.cards[card_index + 1]
    end
    response
  end
end

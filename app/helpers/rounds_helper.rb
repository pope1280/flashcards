def shuffle_cards(cards)
  cards.shuffle!
end

def next_question(args)
  @deck = args[:deck]
  @card = args[:card]
  index = @deck.cards.index(@card)
  next_card = @deck.cards[index + 1]
  return next_card
end

def replay_question(args)
  puts "REPLAY!"
end

def round_complete
  guesses = current_user.rounds.last.guesses
  @round_results = {correct: 0, incorrect: 0}
  
  guesses.each do |guess|
    if guess.result == "correct"
      @round_results[:correct] += 1
    else
      @round_results[:incorrect] += 1
    end
  end
  @round_results
end

def round_deck
  deck_id = current_user.rounds.last.deck_id
  @deck = Deck.find(deck_id)
  p @deck
end

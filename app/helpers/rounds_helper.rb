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
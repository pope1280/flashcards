require 'debugger'

post '/guesses' do
  content_type :json 
  
  @card = Card.find(params[:guess]["card_id"])
  @round = Round.find(params[:guess]["round_id"])
  @deck = Deck.find(@card.deck_id)
  @guess = Guess.new(params[:guess])
  
  if @guess.save
    response = @guess.check_answer

    if response[:round_status] == "over"
      @status = response[:round_status]
      {status: @status, redirect: '/round/complete', card: @card, deck: @deck, round: @round, guess: @guess.result}.to_json
    else
      @next_card = response[:card]
      {card: @next_card, deck: @deck, round: @round, guess: @guess.result}.to_json
    end
  else
    @messages = @guess.errors.messages
    {card: @card, deck: @deck, round: @round }.to_json
  end
end

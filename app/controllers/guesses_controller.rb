require 'debugger'

# Refactor this
post '/guesses' do 
  @card = Card.find(params[:guess]["card_id"])
  @round = Round.find(params[:guess]["round_id"])
  @deck = Deck.find(@card.deck_id)
  @guess = Guess.new(params[:guess])
  if @guess.save
    response = @guess.check_answer
    if response[:round_status] == "over"
      @messages = @guess.result
      erb :'index'
    else
      debugger
      @messages = @guess.result
      erb :'/cards/_display_question', :locals => {card: response[:card], deck: @deck, round: @round }
    end
  else
    @messages = @guess.errors.messages
    erb :'/cards/_display_question', :locals => {card: @card.id, deck: @deck.id, round: @round.id }
  end
end

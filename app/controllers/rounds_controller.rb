require 'debugger'

post '/rounds' do 
  @round = Round.new(params[:round])
  # need to wait until user info is ready
  #@round.user_id = current_user.id
  if @round.save
    @message = "Get Ready!"
    redirect "/round/#{@round.id}"
  else
    @message = @round.errors.messages
    erb :'rounds/new'
  end
end

get '/round/:id' do 
  @round = Round.find(params[:id])
  @deck = Deck.find(@round.deck_id)
  @cards = @deck.cards.shuffle
  erb :'rounds/start'
end

get '/round/:id/shuffle' do
  @deck = Deck.find(@round.deck_id)
  @cards = @deck.cards.shuffle!
  @cards
end

get '/round/:round_id/card/:card_id' do
  @round = Round.find(params[:round_id])
  @card = Card.find(params[:card_id])
  @deck = Deck.find(@card.deck_id)
  erb :'cards/_display_question', :locals => {:round => @round, :deck => @deck, :card => @card}
end

post '/round/:id/guesses' do 
  @guess = Guess.new(params[:guess])
  @guess.round_id = params(round[:id])
  if @guess.save
    if @guess.check_answer == true
      @message = ["Nice!", "Great!", "Terrific!"].sample
      debugger
      next_question
    else
      @message = "Sorry, not correct"
      next_question()
    end
  else
    @message = @guess.errors.messages
    replay_question
  end
end

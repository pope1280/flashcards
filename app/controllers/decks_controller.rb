require 'debugger'
# get '/decks' do 
#   # need before filter here for logged in users
#   @decks = Deck.all
#   erb :'decks/index'
# end

get '/decks/new' do 
  # @deck = Deck.new()
  erb :'decks/new'
end

get '/deck/:id' do 
  @deck = Deck.find(params[:id])
  erb :'decks/show'
end

get '/deck/:id/add_cards' do 
  @deck = Deck.find(params[:id])
  erb :'decks/add_cards'
end

post '/decks' do 
  @deck = Deck.new(params[:deck])
  @deck.user_id = current_user.id

  if @deck.save
    @messages = "Your deck has been saved"
    redirect "/deck/#{@deck.id}/add_cards"
  else
    @messages = @deck.errors.messages
    erb :'decks/new'
  end
end

post '/deck/:id/add_cards' do 
  @deck = Deck.find(params[:id])
  card = params[:deck]["cards"]
  @deck.cards << Card.create(question: card["question"], answer: card["answer"], deck_id: @deck.id)
  
  if params[:button] == "another_card"
    redirect "/deck/#{@deck.id}/add_cards"
  else
    redirect '/user/decks'
  end
end
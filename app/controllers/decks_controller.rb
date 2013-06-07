require 'debugger'
get '/decks' do 
  # need before filter here for logged in users
  @decks = Deck.all
  erb :'decks/index'
end

get '/decks/new' do 
  @deck = Deck.new()
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
  # need to refactor for current user stuff
  @deck = Deck.new(params[:deck])
  # @deck.user_id = current_user
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
  cards = params[:cards]
  @cards = []
  cards.each {|card| @cards << Card.create(:question => card["question"], 
                                :answer => card["answer"], 
                                :deck_id => @deck.id)}
  debugger
  @deck.cards = @cards
  @deck.save
  erb :'decks/show'
end
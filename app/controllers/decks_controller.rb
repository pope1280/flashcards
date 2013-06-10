require 'debugger'

get '/decks/new' do 
  erb :'decks/new'
end

get '/deck/:id/add_cards' do 
  @deck = Deck.find(params[:id])
  erb :'decks/add_cards'
  # :locals => {deck: @deck}
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
  content_type :json
  @deck = Deck.find(params[:id])
  card = Card.new(params[:deck]["cards"])
  if card.save
    @deck.cards << card
    if params[:button] == "another_card"
      response = {}
      response[:success] = true
      response[:card] = card
      response.to_json
    else
      redirect '/user/decks'
    end
  else
    response = {}
    response[:success] = false
    response.to_json
  end
end

# post '/deck/:id/add_cards' do 
#   content_type :json
#   @deck = Deck.find(params[:id])
#   cards = Card.new(params[:deck]["cards"])
# end
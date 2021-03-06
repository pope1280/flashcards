require 'debugger'

post '/rounds' do 
  @round = Round.new(params[:round])
  @round.deck_id = params[:round]["deck_id"]
  @round.user_id = current_user.id
  if @round.save
    @message = "Round successfully started"
    redirect "/round/#{@round.id}"
  else
    @messages = @round.errors.messages
    erb :'/rounds/_new'
  end
end

get '/round/complete' do
  erb :'/rounds/round_complete'
end

get '/round/:id' do 
  @round = Round.find(params[:id])
  @deck = Deck.find(@round.deck_id)
  @cards = @deck.cards
  erb :'rounds/show'
end



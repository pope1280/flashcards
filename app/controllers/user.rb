get '/login' do
 erb :'user_views/login'
end

post '/login' do
  user = User.find_by_email(params[:email])
  
  if user.password == params[:password]
    session[:user_id] = user.id
    redirect "/user/profile"
  else
    redirect '/login'
    #display authentication errors (need to build a partial for this)
  end
end 

get '/user/decks' do
  if current_user
    erb :'decks/user_decks'
  else
    redirect '/'
  end
end

get '/user/profile' do
  if current_user
    @gravatar_hash = Digest::MD5.hexdigest(current_user.email)
    erb :'user_views/profile'
  else 
    redirect '/'
  end
end

get '/sign_up' do 
  erb :'user_views/sign_up'
end

post '/sign_up' do
  user = User.create(params[:user])
  
  if user.valid?
    session[:user_id] = user.id
    redirect "user/profile"
  else
    @errors = []
    erb :'user_views/sign_up'
    #display authentication errors
  end
end

get '/logout' do
  session.clear
  redirect '/'
end

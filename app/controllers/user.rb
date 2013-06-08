get '/login' do
 erb :'user_views/login'
end

post '/login' do
  p params
  user = User.find_by_email(params[:email])
  
  if user.password == params[:password]
    session[:user_id] = user.id
    "Yay!"
    #view to render?  profile page maybe?
  else
    redirect '/login'
    #display authentication errors (need to build a partial for this)
  end
end  

get '/sign_up' do 
  erb :'user_views/sign_up'
end

post '/sign_up' do
  user = User.create(params[:user])
  
  if user.valid?
    session[:user_id] = user.id
    "hi"
    #view to render?  profile page maybe?
  else
    @errors = []
    erb :'user_views/sign_up'

  end
end

get '/logout' do
  session.clear
  redirect '/'
end

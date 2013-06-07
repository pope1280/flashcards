get '/login' do
 erb :'user_views/login'
end

post '/login' do
  p params
  user = User.find_by_email(email: params[:email])
  
  if user.password == params[:password]
    session[:user_id] = user.id
    #view to render?  profile page maybe?
  else
    redirect '/login'
    #display authentication errors (need to build a partial fro this)
  end
end  

get '/sign_up' do
  p params
  user = User.create(params[:user])
  if user.valid?
    session[:user_id] = user.id
    #view to render?  profile page maybe?
  erb :'user_views/sign_up'
end

get '/logout' do
  session.clear
  redirect '/'
end

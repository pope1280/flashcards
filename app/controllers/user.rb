get '/login' do
 erb :'user_views/login'
end

post '/login' do
  email = params[:user][:email]
  @user = User.find_by_email(email: email)
  #need to finish!
end  

get '/sign_up' do
  erb :'user_views/sign_up'
end

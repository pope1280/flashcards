require 'bcrypt'

class User < ActiveRecord::Base
  validates :name, :presence => true
  validates :email, :presence => true,
                    :uniqueness => true,
                    :format => { :with => /\w+@\w+.(\D{3}|\D{2})/,
                    :message => "Please enter a valid email"}
  validates :password, :presence => true

  
  has_many :decks, :dependent => :destroy
  has_many :rounds
  
 include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

end

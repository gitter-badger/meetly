


class User < ActiveRecord::Base

attr_accessor :password

before_save :encrypt_password
after_save :clear_password

validates :name, :presence => true, :uniqueness => true, :length => { :in => 3..20 }
validates_length_of :password, :in => 8..20, :on => :create
validates :password, :presence => true

def encrypt_password
	self.salt = BCrypt::Engine.generate_salt
	puts 'salt created!'
	puts "#{self.salt}"
	self.encrypted_password = BCrypt::Engine.hash_secret(self.password, self.salt)
	puts 'encryption created!'
	puts "#{self.encrypted_password}"
end

def clear_password
	self.password = 'cleared!'
	puts 'pswd cleared!'
end

def self.authenticate(username="", login_password="")
	user = User.find_by(name: username)

	if user && user.match_password(login_password)
    	return user
  	else
    	return false
  	end
end

		  
	   
def match_password(login_password="")
  encrypted_password == BCrypt::Engine.hash_secret(login_password, salt)
end


end
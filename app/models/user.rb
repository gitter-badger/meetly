class User < ActiveRecord::Base
  attr_accessor :password

  before_save :encrypt_password
  after_save :clear_password

  validates :name, presence: true, uniqueness: true, length: { in: 3..20 }
  validates_length_of :password, in: 8..20, on: :create
  validates :password, presence: true

  def encrypt_password
    salt = BCrypt::Engine.generate_salt
    puts 'salt created!'
    puts "#{salt}"

    encrypted_password = BCrypt::Engine.hash_secret(password, salt)
    puts 'encryption created!'
    puts "#{encrypted_password}"
  end

  def clear_password
    self.password = 'cleared!'
    puts 'pswd cleared!'
  end

  def self.authenticate(username = "", login_password = "")
    user = User.find_by(name: username)
    user && user.match_password(login_password) if user
  end

  def match_password(login_password = "")
    encrypted_password == BCrypt::Engine.hash_secret(login_password, salt)
  end
end

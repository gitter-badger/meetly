class User < ActiveRecord::Base
  validates :name, uniqueness: true, length: { in: 3..20 }
  validates :password, length: { in: 8..20 }, on: :create
  validates :password, :name, :email, presence: true

  has_secure_password

  def self.authenticate(username, password)
    user = User.find_by(name: username)
    user.authenticate(password) if user
  end
end

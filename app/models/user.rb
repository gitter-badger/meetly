class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true, uniqueness: true, length: { in: 3..20 }

  def self.authenticate(username, password)
    user = User.find_by(name: username)
    user.authenticate(password) if user
  end
end

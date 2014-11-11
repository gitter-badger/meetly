require 'test_helper'

class UserTest < ActiveSupport::TestCase

should validate_presence_of(:name)
should validate_uniqueness_of(:name)
should validate_presence_of(:password)
should ensure_length_of(:name).is_at_least(3).is_at_most(20)
should ensure_length_of(:password).is_at_least(8).is_at_most(20)


test "saved user has password 'cleared'" do
	u = User.new
	u.name = 'dummy'
	u.password ='dummypassword'
	u.save!

	assert_equal 'cleared!', u.password, "Password not cleared!!"
	assert_not_nil u.encrypted_password, "Encrypted pswd is nil!"
	assert_not_nil u.salt, "Salt is nil!"
	assert User.all.length>0, "User not saved!"
end


end

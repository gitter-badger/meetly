require 'rails_helper'

RSpec.describe ServiceGroup, type: :model do
	describe 'ActiveModel validations' do
		it 'has valid factory' do
			FactoryGirl.create(:service_group)
		end
	end
end

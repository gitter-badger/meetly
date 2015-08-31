require 'rails_helper'

RSpec.describe Service, type: :model do
	describe 'ActiveModel validations' do
		it 'has valid factory for a sequence of services' do
			FactoryGirl.create(:event)
			FactoryGirl.create(:service_group)
			FactoryGirl.create(:service)
			FactoryGirl.create(:service)
		end
	end
end

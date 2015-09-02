require 'rails_helper'

RSpec.describe ServicePrice, type: :model do
  before(:each) do
    FactoryGirl.create(:event)
  end

  describe 'ActiveModel validations' do
    it 'has valid factory' do
      expect(FactoryGirl.create(:service_price)).to be_valid
    end

    it 'is not valid without price'

    it 'is not valid without role'

    it 'is not valid without service'

    it 'validates uniqueness of role in scope of service'
  end
end

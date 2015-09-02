require 'rails_helper'

RSpec.describe Service, type: :model do
  before(:each) do
    FactoryGirl.create(:event)
    FactoryGirl.create(:service_group)
  end

  describe 'ActiveModel validations' do
    it 'has valid factory for a sequence of services' do
      expect(FactoryGirl.create(:service)).to be_valid
      expect(FactoryGirl.create(:service)).to be_valid
    end

    it 'is not valid without name'

    it 'is not valid without event'

    it 'is valid when limit is nil'

    it 'is valid without service_group'
  end
end

require 'rails_helper'

RSpec.describe ServiceGroup, type: :model do
  describe 'ActiveModel validations' do
    it 'has valid factory' do
      expect(FactoryGirl.create(:service_group)).to be_valid
    end
  end
end

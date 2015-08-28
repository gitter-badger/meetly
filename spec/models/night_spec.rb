require 'rails_helper'

describe Night do
  describe 'ActiveModel validations' do
    it 'has a valid factory' do
      expect(FactoryGirl.create(:night)).to be_valid
    end
  end
end

require 'rails_helper'

describe Role do
  describe 'ActiveModel validations' do
    it 'has a valid factory' do
      expect(FactoryGirl.create(:role)).to be_valid
    end
  end
end

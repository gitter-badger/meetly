require 'rails_helper'

describe User do
  describe 'ActiveModel validations' do
    it 'has a valid factory' do
      expect(FactoryGirl.create(:user)).to be_valid
    end
  end
end

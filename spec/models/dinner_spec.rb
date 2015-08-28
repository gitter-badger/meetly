require 'rails_helper'

describe Dinner do
  describe 'ActiveModel validations' do
    it 'has a valid factory' do
      expect(FactoryGirl.create(:dinner)).to be_valid
    end
  end
end

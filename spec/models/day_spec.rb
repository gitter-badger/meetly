require 'rails_helper'

describe Day do
  describe 'ActiveModel validations' do
    it 'has a valid factory' do
      expect(FactoryGirl.create(:day)).to be_valid
    end
  end
end

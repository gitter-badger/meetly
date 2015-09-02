require 'rails_helper'

describe Role do
  before(:each) do
    FactoryGirl.create(:event)
  end

  describe 'ActiveModel validations' do
    it 'has a valid factory' do
      expect(FactoryGirl.create(:role)).to be_valid
    end

    it 'is not valid without event'

    it 'is not valid without name'

    it 'validates uniqueness of name for event'
  end
end

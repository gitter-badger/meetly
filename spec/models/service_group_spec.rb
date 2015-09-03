require 'rails_helper'

RSpec.describe ServiceGroup, type: :model do
  describe 'ActiveModel validations' do
    it 'has valid factory' do
      expect(FactoryGirl.create(:service_group)).to be_valid
    end

    it 'is not valid without name' do
      expect(FactoryGirl.build(:service_group, name: nil)).to_not be_valid
    end

    it 'validates uniqueness of name' do
      FactoryGirl.create(:service_group, name: 'identical')

      expect(FactoryGirl.build(:service_group, name: 'identical')).to_not be_valid
    end
  end
end

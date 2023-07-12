require 'rails_helper'

RSpec.describe Group, type: :model do

  before(:each) do
    @user = User.create(name: 'Test User', email: 'test@example.com', password: 'password')
    @group = Group.create(name: 'Test Group', user: @user)
  end

  describe 'validations' do

    it 'is not valid without a name' do
      @group.name = nil
      expect(@group).to_not be_valid
    end

    it 'is not valid without an icon' do
      @group.icon = nil
      expect(@group).to_not be_valid
    end
  end

  describe 'associations' do
    it 'belongs to a user' do
      association = Group.reflect_on_association(:user)
      expect(association.macro).to eq(:belongs_to) 
    end

    it 'has many entities' do
      association = Group.reflect_on_association(:entities)
      expect(association.macro).to eq(:has_many)
    end
  end

end

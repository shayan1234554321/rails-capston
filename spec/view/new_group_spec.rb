require 'rails_helper'

RSpec.describe 'groups/new', type: :feature do

  before(:each) do
    @user = User.create(name: 'shayan', email: 'shayan@gmail.com', password: 'abc123',
        password_confirmation: 'abc123')

    login_as(@user, scope: :user)
  end

  it 'displays a form to create a new group' do
    visit new_group_path
    expect(page).to have_field('group_name')
    expect(page).to have_button('Create Group')
  end

  it 'redirects to the groups index page after creating a group' do
    visit new_group_path
    click_button 'Create Group'
    expect(current_path).to eq(groups_path)
    expect(page).to have_content('add a new category')
  end

end
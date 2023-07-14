require 'rails_helper'

RSpec.describe 'entites/new', type: :feature do
  before(:each) do
    @user = User.create(name: 'shayan', email: 'shayan@gmail.com', password: 'abc123',
                        password_confirmation: 'abc123')

    login_as(@user, scope: :user)
    file_path = Rails.root.join('app', 'assets', 'images', 'back.png')
    image = File.open(file_path)
    @group = Group.new(name: 'New group', user_id: @user.id)
    @group.icon.attach(io: image, filename: 'back.png', content_type: 'image/png')
    @group.save
  end

  it 'displays a form to create a new group' do
    visit new_group_entity_path(group_id: @group.id)
    expect(page).to have_button('Create Entity')
  end

  it 'has a name field' do
    visit new_group_entity_path(@group)
    expect(page).to have_field('entity_name')
  end

  it 'has an amount field' do
    visit new_group_entity_path(@group)
    expect(page).to have_field('entity_amount')
  end

  it 'preselects the current group' do
    visit new_group_entity_path(@group)
    expect(find_field('entity_group_id').value).to eq(@group.id.to_s)
  end

  it 'has a submit button' do
    visit new_group_entity_path(@group)
    expect(page).to have_button('Create Entity')
  end

  it 'redirects to the entity index page after submit' do
    visit new_group_entity_path(@group)
    fill_in 'Name', with: 'Expense'
    fill_in 'Amount', with: '100'
    click_button 'Create Entity'

    expect(current_path).to eq(group_entities_path(@group))
  end
end

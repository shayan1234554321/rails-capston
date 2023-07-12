require 'rails_helper'

RSpec.describe 'groups/index', type: :feature do
  before(:each) do
    @user = User.create(name: 'shayan', email: 'shayan@gmail.com', password: 'abc123',
                        password_confirmation: 'abc123')

    sign_in @user, scope: :user

    file_path = Rails.root.join('app', 'assets', 'images', 'back.png')
    image = File.open(file_path)
    @group = Group.new(name: 'New group', user_id: @user.id)
    @group.icon.attach(io: image, filename: 'back.png', content_type: 'image/png')
    @group.save
    @groups = [@group]
  end

  it "displays the header with menu icon, title and logout button" do
    visit groups_path
    expect(page).to have_content('add a new category')
  end

  it 'displays each group name' do
    visit groups_path
    @groups.each do |group|
      expect(page).to have_content(group.name) 
    end
  end

  it 'displays the total amount for each group' do
    visit groups_path
    @groups.each do |group|
      expect(page).to have_content("$ #{group.entities.sum(&:amount)}")
    end
  end

  it 'displays the created at date for each group' do
    visit groups_path
    @groups.each do |group|
      expect(page).to have_content(group.created_at)
    end
  end

  it 'has a link to add a new group' do
    visit groups_path
    expect(page).to have_link('add a new category', href: new_group_path)
  end

end
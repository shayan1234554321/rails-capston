require 'rails_helper'

RSpec.describe "entities/index", type: :feature do

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

  it "shows a list of entities for a group" do
    entity1 = @user.entities.create(name: "Expense 1", amount: 100, group: @group)
    entity2 = @user.entities.create(name: "Expense 2", amount: 200, group: @group)

    visit group_entities_path(group_id: @group.id)

    expect(page).to have_content(entity1.name)
    expect(page).to have_content(entity2.name)
  end

  it "shows the total amount for the group" do
    entity1 = @user.entities.create(name: "Expense 1", amount: 100, group: @group)
    entity2 = @user.entities.create(name: "Expense 2", amount: 200, group: @group)
    
    visit group_entities_path(@group)

    expect(page).to have_content("$ 300")
  end

  it "has a link to add a new transaction" do
    visit group_entities_path(@group)

    expect(page).to have_link("add a new transaction")
  end

  it "redirects to the new transaction page when add link clicked" do
    visit group_entities_path(@group)
    
    click_link "add a new transaction"

    expect(current_path).to eq(new_group_entity_path(@group))
  end

end
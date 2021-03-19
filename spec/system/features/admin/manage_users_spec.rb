require 'rails_helper'

feature %Q{
  As an Admin
  ISBAT manage users
}, ' -' do

  before do
    @admin      = create :admin
    @dispatcher = create :dispatcher

    login_as(@admin, scope: :user)
    visit admin_root_path

    within '#header' do
      click_link 'Settings'
      click_link 'Users'
    end
  end

  scenario 'Create user', js: true do
    click_link 'New User'

    attrs = attributes_for(:user)

    fill_in 'Name',                  with: attrs[:name]
    fill_in 'Email',                 with: attrs[:email]
    fill_in 'Password',              with: attrs[:password]
    fill_in 'Password confirmation', with: attrs[:password]

    click_button 'Create User'
    expect(page).to have_content('User was successfully created.')

    click_link 'Edit User'
    user = User.where(email: attrs[:email]).first

    expect(user).to be_present
    expect(user.name).to eq(attrs[:name])
  end

  scenario 'Update user' do
    within "##{dom_id(@dispatcher)}" do
      click_link 'Edit'
    end

    attrs = attributes_for(:user)


    fill_in 'Name',                 with: attrs[:name]
    fill_in 'Email Address',        with: attrs[:email]
    fill_in 'New Password',         with: attrs[:password]
    fill_in 'Confirm New Password', with: attrs[:password]

    click_button 'Update User'
    expect(page).to have_content('User was successfully updated.')

    user = User.where(email: attrs[:email]).first
    expect(user).to be_present
    expect(user.name).to eq(attrs[:name])
    expect(User.where(email: @dispatcher.email)).to_not be_present
  end

  scenario 'Update Current Admin Profile' do
    within "##{dom_id(@admin)}" do
      click_link 'Edit'
    end

    attrs = attributes_for(:admin)


    fill_in 'Name',                 with: attrs[:name]
    fill_in 'Email Address',        with: attrs[:email]
    fill_in 'New Password',         with: attrs[:password]
    fill_in 'Confirm New Password', with: attrs[:password]

    click_button 'Update User'
    expect(page).to have_content('User was successfully updated.')

    user = User.where(email: attrs[:email]).first
    expect(user).to be_present
    expect(user.name).to eq(attrs[:name])
    expect(User.where(email: @admin.email)).to_not be_present
  end

  scenario 'View user' do
    within "##{dom_id(@dispatcher)}" do
      click_link 'View'
    end

    expect(page).to have_content(@dispatcher.name)
  end

  scenario 'Delete user' do
    within "##{dom_id(@dispatcher)}" do
      click_link 'Delete'
    end

    expect(page).to have_content('User was successfully destroyed.')
    expect(User.where(id: @dispatcher.id)).to_not be_present
  end
end

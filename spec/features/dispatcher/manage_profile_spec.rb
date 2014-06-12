require 'rails_helper'

feature %Q{
  As a dispatcher
  ISBAT manage my account
}, ' -' do

  before do
    @dispatcher  = create :dispatcher

    login_as(@dispatcher, scope: :user)

    visit '/'
  end

  scenario 'Update dispatcher', js: true do

    click_link 'Edit Profile'

    attrs = attributes_for :dispatcher

    fill_in 'Full Name',            with: attrs[:name]
    fill_in 'Email Address',        with: attrs[:email]
    fill_in 'New Password',         with: attrs[:password]
    fill_in 'Confirm New Password', with: attrs[:password]

    click_button 'Update User'

    expect(page).to have_content('User was successfully updated.')
    expect(page).to have_content("#{attrs[:name]}")
    @dispatcher.reload

    dispatcher = User.find(@dispatcher.id)

    expect(dispatcher.name).to eq(attrs[:name])
    expect(dispatcher.email).to eq(attrs[:email])

    visit '/'

    click_link "Sign out"

    # Login with the new credentials
    click_link 'Login'

    within '.modal-body' do
      fill_in 'user[email]',    with: attrs[:email]
      fill_in 'user[password]', with: attrs[:password]

      click_button 'Login'
    end

    expect(page).to have_content('Signed in successfully.')

    click_link 'Edit Profile'

    new_email = Faker::Internet.email

    fill_in 'Email Address', with: new_email
    click_button 'Update User'

    expect(page).to have_content('User was successfully updated.')

    dispatcher = User.find(@dispatcher.id)
    expect(dispatcher.name).to eq(attrs[:name])
    expect(dispatcher.email).to eq(new_email)

    click_link 'Logout'

    click_link 'Login'

    within '.modal-body' do
      fill_in 'user[email]',    with: new_email
      fill_in 'user[password]', with: attrs[:password]

      click_button 'Login'
    end

    expect(page).to have_content('Signed in successfully.')
  end


end

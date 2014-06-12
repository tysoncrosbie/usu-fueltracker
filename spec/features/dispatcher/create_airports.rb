require 'rails_helper'

feature %Q{
  As a Dispatcher
  ISBAT create airports
}, ' -' do

  before do
    @dispatcher = create :dispatcher
    @airport    = create :airport


    login_as(@dispatcher, scope: :user)
    visit admin_root_path

    within '#header' do
      click_link 'Invoicing'
      click_link 'Receipts'
    end
  end

  scenario 'Create airport' do
    click_link 'New Receipt'
    click_link 'Create a new Airport'

    attrs = attributes_for(:airport)

    fill_in 'Faa code',              with: attrs[:faa_code]
    fill_in 'Airport name',          with: attrs[:airport_name]
    fill_in 'airport[city]',         with: attrs[:city]
    fill_in 'airport[state]',        with: attrs[:state]

    click_button 'Create Airport'
    expect(page).to have_content('Airport was successfully created.')
  end
end
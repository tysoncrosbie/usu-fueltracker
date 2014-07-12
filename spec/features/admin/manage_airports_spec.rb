require 'rails_helper'

feature %Q{
  As an Admin
  ISBAT manage airports
}, ' -' do

  before do
    @admin      = create :admin
    @airport    = create :airport


    login_as(@admin, scope: :user)
    visit admin_root_path

    within '#header' do
      click_link 'Settings'
      click_link 'Airports'
    end
  end

  scenario 'Create airport' do
    click_link 'New Airport'

    attrs = attributes_for(:airport)

    fill_in 'Faa code',              with: attrs[:faa_code]
    fill_in 'Airport name',          with: attrs[:airport_name]
    fill_in 'airport[city]',         with: attrs[:city]
    fill_in 'airport[state]',        with: attrs[:state]

    click_button 'Create Airport'
    expect(page).to have_content('Airport was successfully created.')
  end

  scenario 'Update airport' do
    within "##{dom_id(@airport)}" do
      click_link 'Edit'
    end

    attrs = attributes_for(:airport)

    fill_in 'Faa code',              with: attrs[:faa_code]
    fill_in 'Airport name',          with: attrs[:airport_name]
    fill_in 'airport[city]',         with: attrs[:city]
    fill_in 'airport[state]',        with: attrs[:state]

    click_button 'Update Airport'
    expect(page).to have_content('Airport was successfully updated.')
  end

  scenario 'Delete airport' do

    within "##{dom_id(@airport)}" do
      click_link 'Delete'
    end

    expect(page).to have_content('Airport was successfully destroyed.')
    expect(Airport.where(id: @airport.id)).to_not be_present
  end
end
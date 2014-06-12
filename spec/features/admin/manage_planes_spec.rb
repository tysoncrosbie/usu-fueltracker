require 'rails_helper'

feature %Q{
  As an Admin
  ISBAT manage planes
}, ' -' do

  before do
    @admin      = create :admin
    @plane      = create :plane


    login_as(@admin, scope: :user)
    visit admin_root_path

    within '#header' do
      click_link 'Settings'
      click_link 'Planes'
    end
  end

  scenario 'Create plane' do
    click_link 'New Plane'

    attrs = attributes_for(:plane)

    fill_in 'Tail number',        with: attrs[:tail_number]
    fill_in 'Plane type',         with: attrs[:plane_type]
    choose 'plane[fuel_type]'

    click_button 'Create Plane'
    expect(page).to have_content('Plane was successfully created.')
  end

  scenario 'Update plane' do
    within "##{dom_id(@plane)}" do
      click_link 'Edit'
    end

    attrs = attributes_for(:plane)

    fill_in 'Tail number',        with: attrs[:tail_number]
    fill_in 'Plane type',         with: attrs[:plane_type]
    choose 'plane[fuel_type]'

    click_button 'Update Plane'
    expect(page).to have_content('Plane was successfully updated.')
  end

  scenario 'View plane' do

    within "##{dom_id(@plane)}" do
      click_link 'View'
    end

    expect(page).to have_content(@plane.tail_number)
    expect(page).to have_content(@plane.plane_type)
    expect(page).to have_content(@plane.fuel_type)
  end

  scenario 'Delete plane' do

    within "##{dom_id(@plane)}" do
      click_link 'Delete'
    end

    expect(page).to have_content('Plane was successfully destroyed.')
    expect(Plane.where(id: @plane.id)).to_not be_present
  end
end
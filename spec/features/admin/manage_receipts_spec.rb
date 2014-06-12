require 'rails_helper'

feature %Q{
  As an Admin
  ISBAT manage receipts
}, ' -' do

  before do
    @admin      = create :admin
    @receipt    = create :receipt
    @nfc        = create :non_fuel_charge, receipt_id: @receipt.id
    @plane      = create :plane
    @airport    = create :airport


    login_as(@admin, scope: :user)
    visit admin_root_path

    within '#header' do
      click_link 'Invoicing'
      click_link 'Receipts'
    end
  end

  scenario 'Create receipt', js: true do
    click_link 'New Receipt'

    attrs = attributes_for(:receipt)
    nfc_attrs = attributes_for(:non_fuel_charge)

    select_from_chosen "#{@plane.tail_number} - #{@plane.plane_type}", from: "Plane"
    select_from_chosen "#{@airport.faa_code} - #{@airport.airport_name} - #{@airport.city}, #{@airport.state}", from: 'Airport'
    fill_in 'Receipt number',           with: attrs[:receipt_number]
    fill_in 'Vendor name',              with: attrs[:vendor_name]
    fill_in 'Total Gallons Purchased',  with: attrs[:gallons]
    fill_in 'Fuel Total Cost',          with: attrs[:fuel_cost]
    fill_in 'Receipt date',             with: attrs[:receipt_date].to_date

    click_link 'Add New Non fuel charge'

    fill_in 'Student name',             with: nfc_attrs[:student_name]
    fill_in 'Charge type',              with: nfc_attrs[:charge_type]
    fill_in 'Amount',                   with: nfc_attrs[:amount]

    click_button 'Create Receipt'
    expect(page).to have_content('Receipt was successfully created.')
  end

  scenario 'Update receipt', js: true do
    within "##{dom_id(@receipt)}" do
      click_link 'Edit'
    end

    attrs = attributes_for(:receipt)
    nfc_attrs = attributes_for(:non_fuel_charge)

    select_from_chosen "#{@plane.tail_number} - #{@plane.plane_type}", from: "Plane"
    select_from_chosen "#{@airport.faa_code} - #{@airport.airport_name} - #{@airport.city}, #{@airport.state}", from: 'Airport'
    fill_in 'Receipt number',           with: attrs[:receipt_number]
    fill_in 'Vendor name',              with: attrs[:vendor_name]
    fill_in 'Total Gallons Purchased',  with: attrs[:gallons]
    fill_in 'Fuel Total Cost',          with: attrs[:fuel_cost]
    fill_in 'Receipt date',             with: attrs[:receipt_date].to_date

    fill_in 'Student name',             with: nfc_attrs[:student_name]
    fill_in 'Charge type',              with: nfc_attrs[:charge_type]
    fill_in 'Amount',                   with: nfc_attrs[:amount]

    click_button 'Update Receipt'
    expect(page).to have_content('Receipt was successfully updated.')
  end

  scenario 'View receipt' do

    within "##{dom_id(@receipt)}" do
      click_link 'View'
    end

    expect(page).to have_content(@receipt.receipt_number)
    expect(page).to have_content(@receipt.receipt_date.strftime('%B %d, %Y'))
    expect(page).to have_content(@receipt.vendor_name)
    expect(page).to have_content(@receipt.gallons)
    expect(page).to have_content(@receipt.fuel_cost)
    expect(page).to have_content(@nfc.student_name)
    expect(page).to have_content(@nfc.charge_type)
    expect(page).to have_content(@nfc.amount)
  end

  scenario 'Delete receipt' do

    within "##{dom_id(@receipt)}" do
      click_link 'Delete'
    end

    expect(page).to have_content('Receipt was successfully destroyed.')
    expect(Receipt.where(id: @receipt.id)).to_not be_present
  end
end
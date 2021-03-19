require 'rails_helper'

feature %Q{
  As an Admin
  ISBAT manage reports
}, ' -' do

  before do
    @admin      = create :admin
    @report     = create :usu_environmental

    login_as(@admin, scope: :user)
    visit admin_root_path

    within '#header' do
      click_link 'Reports'
    end
  end

  scenario 'Create report' do
    click_link 'New Report'

    attrs = attributes_for(:report)

    fill_in 'Name',         with: attrs[:name]
    fill_in 'Starts on',    with: attrs[:starts_on].to_date
    fill_in 'Ends on',      with: attrs[:ends_on].to_date
    choose 'report_type_utahtap'

    click_button 'Create Report'
    expect(page).to have_content('Utah tap was successfully created.')
  end

  scenario 'Update report' do
    within "##{dom_id(@report)}" do
      click_link 'Edit'
    end

    attrs = attributes_for(:report)

    fill_in 'Name',         with: attrs[:name]
    fill_in 'Starts on',    with: attrs[:starts_on].to_date
    fill_in 'Ends on',      with: attrs[:ends_on].to_date
    choose 'report_type_utahtap'

    click_button 'Update Usu environmental'
    expect(page).to have_content('Usu environmental was successfully updated.')
  end


  scenario 'Delete report' do

    within "##{dom_id(@report)}" do
      click_link 'Delete'
    end

    expect(page).to have_content('Usu environmental was successfully destroyed.')
    expect(Report.where(id: @report.id)).to_not be_present
  end
end
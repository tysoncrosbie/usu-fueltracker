ActiveAdmin.register NonFuelCharge do
  menu parent: "Invoicing"
  actions :only, :index

  controller do
    def permitted_params
      params.permit non_fuel_charge: [:receipt_id, :student_name, :charge_type, :amount, :status]
    end

    def show
      @page_title = "Non Fuel Charge for "+resource.student_name
    end

    def create
      super do |success,failure|
        success.html { redirect_to admin_non_fuel_charges_path }
      end
    end

    def update
      super do |success,failure|
        success.html { redirect_to admin_non_fuel_charges_path }
      end
    end
  end

  # ACTIONS
  member_action :verify, method: :put do
    non_fuel_charge = NonFuelCharge.find(params[:id])
    non_fuel_charge.verify!
    redirect_to :back, notice: "Charge for #{non_fuel_charge.student_name} has been verified."
  end

  member_action :pend, method: :put do
    non_fuel_charge = NonFuelCharge.find(params[:id])
    non_fuel_charge.pend!
    redirect_to :back, notice: "Charge for #{non_fuel_charge.student_name} has been returned to pending."
  end


  member_action :state_change, method: :patch do
    @non_fuel_charge = NonFuelCharge.find(params[:id])

    case params[:status].to_sym
      when :verified
        head :ok and return if @non_fuel_charge.verified
      when :pending
        head :ok and return if @non_fuel_charge.pending
    end

    head :bad_request
  end

  scope :all
  scope :pending
  scope :verified

  index do
    selectable_column
    column :status do |r|
      r.pending? ? status_tag('pending') : status_tag('verified', :ok)
    end
    column :receipt_date do |n|
      r = Receipt.find(n.receipt_id)
      r.receipt_date.strftime('%B %e, %Y')
    end

    column "Invoice Number", :receipt_id, sortable: :receipt_id do |n|
      r = Receipt.find(n.receipt_id)
      link_to r.receipt_number, admin_receipt_path(r)
    end
    column :student_name
    column :charge_type
    column :amount do |nfc|
      number_to_currency(nfc.amount)
    end
    column :actions do |nfc|
      [].tap do |links|
        unless nfc.verified?
          links << link_to('Verify', verify_admin_non_fuel_charge_path(nfc), method: :put, class: 'member_link' )
        end

        unless nfc.pending?
          links << link_to('Unverify', pend_admin_non_fuel_charge_path(nfc), method: :put, class: 'member_link')
        end
         r = Receipt.find(nfc.receipt_id)
        links << link_to('Edit', edit_admin_receipt_path(r), class: 'member_link')
      end.join(' ').html_safe
    end
  end

  filter :student_name, as: :select

end
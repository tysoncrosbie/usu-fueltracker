ActiveAdmin.register Receipt do
  menu parent: 'Invoicing', priority: 0
  config.sort_order = "receipt_date_desc"

  before_filter :only => [:show] do
    @receipt = Receipt.friendly.find(params[:id])
  end

  controller do
    def permitted_params
      params.permit receipt: [:fuel_cost, :gallons, :id, :receipt_number, :receipt_date, :slug, :plane_id, :status, :airport_id, :vendor_name,
        non_fuel_charges_attributes: [:student_name, :charge_type, :amount, :id, :_destroy]
      ]
    end

    def show
      @page_title = "Receipt / Invoice number "+resource.receipt_number
    end

    def edit
      @page_title = "Receipt / Invoice number "+resource.receipt_number
    end

    def create
      super do |success,failure|
        success.html { redirect_to admin_receipts_path }
      end
    end

    def update
      super do |success,failure|
        success.html { redirect_to admin_receipts_path }
      end
    end
  end

# ACTIONS
  member_action :verify, method: :put do
    receipt = Receipt.friendly.find(params[:id])
    receipt.verify!
    redirect_to :back, notice: "#{receipt.receipt_number} has been verified."
  end

  member_action :pend, method: :put do
    receipt = Receipt.friendly.find(params[:id])
    receipt.pend!
    redirect_to :back, notice: "#{receipt.receipt_number} has been returned to pending."
  end


  member_action :state_change, method: :patch do
    @receipt = Receipt.friendly.find(params[:id])

    case params[:status].to_sym
      when :verified
        head :ok and return if @receipt.verified
      when :pending
        head :ok and return if @receipt.pending
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
    column :receipt_date
    column 'Receipt/ Invoice Number', sortable: :receipt_number do |r|
      r.receipt_number
    end
    column :airport_id do |r|
      "#{r.airport.faa_code} - #{r.airport.airport_name}"
    end
    column :vendor_name
    column :gallons
    column :fuel_cost do |i|
      number_to_currency(i.fuel_cost)
    end
    column :actions do |receipt|
      [].tap do |links|
        unless receipt.verified?
          links << link_to('Verify', verify_admin_receipt_path(receipt), method: :put)
        end

        unless receipt.pending?
          links << link_to('Unverify', pend_admin_receipt_path(receipt), method: :put)
        end
      end.join(' ').html_safe
    end
    actions
  end

  filter :receipt_date
  filter :plane_id, as: :select, collection: Plane.all.map {|p| ["#{p.tail_number.upcase} - #{p.plane_type}", p.id] }
  filter :receipt_number
  filter :vendor_name, as: :select

  show do
    attributes_table do
      row "Receipt | Invoice number" do |r|
        r.receipt_number
      end
      row :status do |r|
        r.verified? ? status_tag('verified', :ok) : status_tag('pending')
      end
      if receipt.pending?
        row :action do |r|
          link_to('Verify', verify_admin_receipt_path(r), method: :put)
        end
      else
        nil
      end
      row :plane_id do |r|
        p = Plane.find(r.plane_id)
        "#{p.tail_number} - #{p.plane_type}"
      end
      row :receipt_date
      row :vendor_name
      row :airport do |r|
        a = Airport.find(r.airport_id)
        r.airport_id.present? ? "#{a.faa_code} - #{a.airport_name} - #{a.city}" : nil
      end
      row :gallons
      row :fuel_cost do |r|
        number_to_currency(r.fuel_cost)
      end
    end
    if receipt.non_fuel_charges.present?
      receipt.non_fuel_charges.each do |nfc|
        panel 'Non-Fuel Charges' do
          attributes_table_for receipt do
            row :status do
              nfc.verified? ? status_tag('verified', :ok) : status_tag('pending')
            end
            if nfc.pending?
              row :action do
                link_to('Verify', verify_admin_non_fuel_charge_path(nfc), method: :put)
              end
            else
              nil
            end
            row :student_name do
              nfc.student_name
            end
            row :charge_type do
              nfc.charge_type
            end
            row :amount do |nf|
              number_to_currency(nfc.amount)
            end
          end
        end
      end
    end
  end

  form do |f|
    f.form_buffers.last << f.send(:with_new_form_buffer) do
      f.template.content_tag :div do
        f.semantic_errors
      end
    end

    f.form_buffers.last << f.send(:with_new_form_buffer) do
      f.template.content_tag :div, class: 'main-form' do

        f.inputs :receipt_details do
          f.input :plane_id, as: :chosen, collection: Plane.all.map{|p| ["#{p.tail_number.upcase} - #{p.plane_type}", p.id]}
          f.input :airport_id, as: :chosen, collection: Airport.all.map{|a| ["#{a.faa_code} - #{a.airport_name} - #{a.city}, #{a.state}", a.id] },
            hint: "Airport not listed? #{link_to('Create a new Airport', new_admin_airport_path)}".html_safe
          f.input :receipt_number, label: 'Receipt / Invoice number', hint: 'Receipt or Invoice number associated with charge.'
          f.input :receipt_date, as: :datepicker, hint: 'Date of charge.'
          f.input :vendor_name
          f.input :gallons, label: "Total Gallons Purchased", placeholder: "000.0"
          f.input :fuel_cost, as: :number, label: "Fuel Total Cost", placeholder: "55.00"
        end

        f.inputs :non_fuel_charges do
          f.has_many :non_fuel_charges, allow_destroy: true do |nf|
            nf.input :student_name
            nf.input :charge_type, placeholder: 'Hangar Fee, Tie-down Fee'
            nf.input :amount, placeholder: '55.00'
          end
        end
      end
    end

    f.form_buffers.last << f.send(:with_new_form_buffer) do
      f.template.content_tag(:aside) do
        f.inputs :reciept_status do
          f.input :status, as: :radio, collection: [:pending, :verified], member_label: -> (s) { (s.to_s.humanize) }
        end
      end
    end

    f.actions
  end

end
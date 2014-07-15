ActiveAdmin.register Receipt do
  menu parent: 'Invoicing', priority: 0
  config.sort_order = "receipt_date_desc"
  collection_action :autocomplete_receipt_vendor_name, method: :get
  actions :all, except: [:show]



  before_filter :only => [:show] do
    @receipt = Receipt.friendly.find(params[:id])
  end

  controller do
    autocomplete :receipt, :vendor_name

    def autocomplete_receipt_vendor_name
      render json: Receipt.select("DISTINCT vendor_name as value").where("LOWER(vendor_name) like LOWER(?)", "%#{params[:term]}%")
    end

    def permitted_params
      params.permit receipt: [:fuel_cost, :gallons, :id, :receipt_number, :receipt_date, :slug, :plane_id, :status, :airport_id, :vendor_name, :reimbursement,
        non_fuel_charges_attributes: [:student_name, :charge_type, :amount, :id, :_destroy]
      ]
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

    def destroy
      super do |success, failure|
        success.html { redirect_to :back, confirm: true }
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
  scope :with_non_fuel_charges
  scope :with_reimbursement


  index do
    column :status do |r|
      r.pending? ? status_tag('pending') : status_tag('verified', :ok)
    end
    column :receipt_date
    column 'Invoice Number', sortable: :receipt_number do |r|
      r.receipt_number
    end
    # column :tail_number do |r|
    #   "#{r.plane.tail_number}"
    # end

    # column :airport_id do |r|
    #   "#{r.airport.faa_code} - #{r.airport.airport_name}"
    # end
    # column :vendor_name
    # column :gallons
    # column :fuel_cost do |i|
    #   number_to_currency(i.fuel_cost)
    # end

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
  filter :airport_id, as: :select, collection: Airport.order('airport_name').map { |a| ["#{a.faa_code} - #{a.airport_name}", a.id] }
  filter :plane_id, as: :select, collection: Plane.all.map {|p| ["#{p.tail_number.upcase} - #{p.plane_type}", p.id] }
  filter :receipt_number
  filter :vendor_name, as: :select

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
          f.input :vendor_name, as: :autocomplete, url: autocomplete_receipt_vendor_name_admin_receipts_path
          f.input :gallons, label: "Total Gallons Purchased", placeholder: "000.0"
          f.input :fuel_cost, as: :number, label: "Fuel Total Cost", placeholder: "55.00"
          f.input :reimbursement, hint: 'Notes about reimbursement.', placeholder: 'John Doe'
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
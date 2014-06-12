ActiveAdmin.register Plane do
  menu parent: 'Settings'

  controller do
    def permitted_params
      params.permit plane: [:fuel_type, :tail_number, :plane_type, :slug, :status]
    end

    def show
      @page_title = "Tail Number: "+resource.tail_number
    end

    def create
      super do |success,failure|
        success.html { redirect_to admin_planes_path }
      end
    end

    def update
      super do |success,failure|
        success.html { redirect_to admin_planes_path }
      end
    end
  end

  # ACTIONS
  member_action :activate, method: :put do
    plane = Plane.friendly.find(params[:id])
    plane.activate!
    redirect_to admin_plane_path(plane), notice: "#{plane.tail_number} has been activated."
  end

  member_action :inactivate, method: :put do
    plane = Plane.friendly.find(params[:id])
    plane.inactivate!
    redirect_to admin_plane_path(plane), alert: "#{plane.tail_number} has been inactivated."
  end

  member_action :state_change, method: :patch do
    @plane = Plane.friendly.find(params[:id])

    case params[:status].to_sym
      when :activated
        head :ok and return if @plane.active
      when :inactivated
        head :ok and return if @plane.inactive
    end

    head :bad_request
  end

  scope :all
  scope :active
  scope :inactive

  index do
    selectable_column
    column :receipts do |p|
      p.receipts.count
    end
    column :status do |p|
      p.active? ? status_tag('active', :ok) : status_tag('inactive', :error)
    end
    column "Tail Number", sortable: :tail_number do |p|
      p.tail_number.upcase
    end
    column "Plane Type", sortable: :plane_type do |p|
      p.plane_type.upcase
    end
    column :fuel_type
    actions
  end

  filter :tail_number, as: :select

  show do
    attributes_table do
      row :status do |p|
        p.active? ? status_tag('active', :ok) : status_tag('inactive', :error)
      end
      row :plane_type
      row :tail_number
      row :fuel_type
      row :number_of_receipts do |p|
        p.receipts.count
      end
      row :total_gallons do |p|
        p.receipts.map(&:gallons).inject(:+)
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
        f.inputs :plane_details do
          f.input :tail_number, placeholder: 'N44740'
          f.input :plane_type, placeholder: 'ARROW'
          f.input :fuel_type, as: :radio, collection: Plane.all.map(&:fuel_type).uniq
        end

        f.inputs :status do
          f.input :status, as: :radio, collection: [:active, :inactive], member_label: -> (s) { (s.to_s.humanize) }
        end
      end
    end

    f.actions
  end

end

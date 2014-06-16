ActiveAdmin.register Airport do
  menu parent: 'Settings'

  controller do
    def permitted_params
      params.permit airport: [:city, :airport_name, :state, :faa_code]
    end

     def create
      super do |success,failure|
        success.html { redirect_to admin_airports_path }
      end
    end

    def show
      @page_title = resource.airport_name
    end

    def edit
      @page_title = 'Edit '+resource.airport_name
    end

    def update
      super do |success,failure|
        success.html { redirect_to admin_airports_path }
      end
    end
  end

  scope :all
  scope :utah_airports
  scope :out_of_state_airports

  index do
    column :airport_name
    column :faa_code
    column :location do |a|
      "#{a.city}, #{a.state}"
    end

    actions
  end

  filter :airport_name
  filter :faa_code

  show do
    attributes_table do
      row :airport_name
      row :faa_code
      row "City, State" do |a|
        "#{a.city}, #{a.state}"
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

        f.inputs :airport_details do
          f.input :faa_code, placeholder: 'LGU'
          f.input :airport_name, placeholder: 'Logan-Cache Airport'
          f.input :city, label: 'City/State', placeholder: 'Logan'
          f.input :state, label: false, placeholder: 'UT'
        end

      end
    end

    f.actions
  end

end
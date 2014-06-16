ActiveAdmin.register Report do

  controller do
    def permitted_params
      params.permit report: [ :name, :type, :starts_on, :ends_on ]
    end

    def show
      @page_title = resource.name

      respond_to do |format|
        format.html
        format.csv { send_data @report.to_csv, filename: "#{@report.name}.csv" }
      end
    end

    def create
      super do |success,failure|
        success.html { redirect_to admin_reports_path }
      end
    end

    def update
      super do |success,failure|
        success.html { redirect_to admin_reports_path }
      end
    end
  end

  sidebar "" do
  end

  scope :all
  scope :utah_tap
  scope :usu_environmental

  index do
    column :name
    column :type
    column :starts_on
    column :ends_on
    column '' do |resource|
      links = ''.html_safe
      links += link_to "Download", resource_path(resource, format: 'csv'), :class => "member_link"
      links += link_to I18n.t('active_admin.edit'), edit_resource_path(resource), :class => "member_link edit_link"
      links += link_to I18n.t('active_admin.delete'), resource_path(resource), :method => :delete, :confirm => I18n.t('active_admin.delete_confirmation'), :class => "member_link delete_link"
      links
    end
  end

  filter :name, as: :select


  form do |f|
    f.form_buffers.last << f.send(:with_new_form_buffer) do
      f.template.content_tag :div do
        f.semantic_errors
      end
    end

    f.form_buffers.last << f.send(:with_new_form_buffer) do
      f.template.content_tag :div, class: 'main-form' do

        f.inputs :report_details do
          f.input :type, label: "Report type", as: :radio, collection: [[ 'Utah TAP', 'UtahTap'], ['USU Environmental', 'UsuEnvironmental' ]]
          f.input :name, placeholder: "2014 USU First Quarter Tax Report"
          f.input :starts_on, as: :datepicker
          f.input :ends_on, as: :datepicker
        end
      end

      f.actions
    end

  end
end
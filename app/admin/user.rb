ActiveAdmin.register User do
  menu parent: 'Settings'

  controller do

    def create
      super do |success,failure|
        success.html { redirect_to admin_user_path(@user) }
      end
    end

    def show
      @page_title = resource.name
    end

    def edit
      @page_title = 'Edit '+resource.name
    end

    def update
      current_user_id = current_user.id

      # Don't require a password when editing a user.
      if params[:user][:password].blank?
         params[:user].delete(:password)
         params[:user].delete(:password_confirmation)
       end

      super do |success,failure|
        success.html { redirect_to admin_user_path(@user) }
      end

       # Don't require a re-login after password changed for current user.
      if current_user_id == @user.id
        sign_in @user, bypass: true
      end
    end

    def permitted_params
      params.permit user: [:anumber, :name, :slug, :email, :password, :password_confirmation, { role_ids: [] }]
    end
  end
  scope :all
  ROLES.each do |r|
    scope r.to_sym, r
  end

  index do
    selectable_column
    column :roles do |u|
      if u.roles_name.present?
        u.has_role?('admin') ? status_tag( "admin", :ok ) :
        u.has_role?('dispatcher') ? status_tag("dispatcher", :warning) :
        nil
      end
    end
    column :name
    column :anumber
    column :email
    column :sign_in_count
    actions
  end

  show do
    attributes_table do
      row :name
      row :anumber
      row :email
    end
  end


  filter :name
  filter :email

  form do |f|
    f.template.content_tag :div do
      f.semantic_errors
    end

    f.template.content_tag :div, class: 'main-form' do
      f.inputs :user_details do
        f.input :name
        f.input :email
        f.input :anumber
      end

      f.inputs :passwords, label: "Update Passwords" do
        f.input :password
        f.input :password_confirmation
      end
    end

    f.template.content_tag(:aside) do
      if current_user.has_role?(:admin)
        f.inputs :roles do
          f.input :role_ids, as: :check_boxes, collection: Role.all.accessible_by(current_ability).collect {|r| [r.name.humanize, r.id]}, label: false
        end
      else
        nil
      end
    end

    f.actions
  end

end

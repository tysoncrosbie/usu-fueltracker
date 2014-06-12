class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  unless Rails.configuration.consider_all_requests_local
    rescue_from Exception, with: :render_500

    rescue_from CanCan::AccessDenied do |exception|
      unauthorized_redirect(exception)
    end

    rescue_from AbstractController::ActionNotFound,  with: :render_404
    rescue_from ActiveRecord::RecordNotFound,        with: :render_404
    rescue_from ActionController::UnknownController, with: :render_404
    rescue_from ActionController::RoutingError,      with: :render_404
    rescue_from URI::InvalidURIError,                with: :render_404
  end


  before_action :configure_permitted_parameters, if: :devise_controller?

  before_filter do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end

  # strong params for everything else (#{resource}_params)
  before_filter unless: :devise_controller? do
    resource = controller_name.singularize.to_sym
    method   = "#{resource}_params"

    params[resource] &&= send(method) if respond_to?(method, true)
  end

  def unauthorized_redirect(*args)
    message = ""
    message = args[0].message unless args.blank?
    redirect_to (user_signed_in? ? main_app.root_path : main_app.new_user_session_path), alert: message
  end

  def authorize_admin!
    authenticate_user!
    unless current_user.has_role?(:admin) || current_user.has_role?(:dispatcher)
      unauthorized_redirect
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:email, :password) }
  end

end

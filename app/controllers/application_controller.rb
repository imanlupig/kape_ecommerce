class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :set_current_cart
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :debug_current_customer
  private

  def debug_current_customer
    Rails.logger.debug "Current customer: #{current_customer.inspect}" if customer_signed_in?
  end

  def set_current_cart
    if session[:current_cart_id]
      @current_cart = Cart.find_by_secret_id(session[:current_cart_id])
    else
      @current_cart = Cart.create
      session[:current_cart_id] = @current_cart.secret_id
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :street, :city, :province, :postal_code ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :street, :city, :province, :postal_code ])
  end
end

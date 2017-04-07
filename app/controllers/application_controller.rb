class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_order
  before_action :configure_permitted_parameters, if: :devise_controller?
	before_filter :set_university

	def check_for_mobile
	    session[:mobile_override] = params[:mobile] if params[:mobile]
	    prepare_for_mobile if mobile_device?
	end

	def prepare_for_mobile
	    prepend_view_path Rails.root + 'app' + 'views_mobile'
	end

	def mobile_device?
	    if session[:mobile_override]
	      session[:mobile_override] == "1"
	    else
	      # Season this regexp to taste. I prefer to treat iPad as non-mobile.
	      (request.user_agent =~ /Mobile|webOS/) && (request.user_agent !~ /iPad/)
	    end
	end

	def current_order
		if session[:order_id]
		  @order ||= Order.find(session[:order_id])
		  session[:order_id] = nil if  @order.purchased_at
		end
	  if session[:order_id].nil?
      if !current_user.nil?
		    @order = Order.new(:user_id => current_user.id)

      else
        @order = Order.new
      end
		end
		@order.payment_status = 'Cart'
		@order.fulfillment_status = 'Cart'
		@order
	end

	helper_method :mobile_device?

protected

	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up) do |u|
	      u.permit(:name, :first_name, :last_name, :gender, :email, :password, :password_confirmation)
	    end
	end

private
	def set_university
			# universities = University.where(subdomain: request.subdomains[0])
			universities = University.where(subdomain: "sdmcet")
			if universities.count > 0
				@_University = universities.first
				@_DynamicUpdate = ""
				university_detail = @_University.university_detail
				unless university_detail.blank?
					@_DynamicUpdate = university_detail.dynamic_update
				end
			end
	end

end

# service chage = 1000
# fee formula = 300 * qty
# dynamic_update = college|ndocs


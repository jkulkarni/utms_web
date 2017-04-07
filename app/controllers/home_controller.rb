class HomeController < ApplicationController

	def home
	end

	def account_details
		@user = current_user
	end

	def temp_individual_application_details
	end

end

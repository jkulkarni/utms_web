module ApplicationHelper
	def current_currency
=begin
		html = ''
		if @current_currency == "PAY IN INR" || @current_currency == "INR"  
		 	html +=  '<span><i class="fa fa-rupee"></i></span>'
		else 
		 	html +=  '<span><i class="fa fa-usd"></i></span>'
		 end 
		 html.html_safe
=end

		html =  '<span><i class="fa fa-rupee"></i></span>'
		html.html_safe

	end

	def current_currency_ruppee
		html = ''
		html +=  '<span><i class="fa fa-rupee"></i></span>'
		html.html_safe
	end
end

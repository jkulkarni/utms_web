class TransactionsController < ApplicationController
	before_action :authenticate_user!, only: [:express], :raise => false

	def express
	  response = EXPRESS_GATEWAY.setup_purchase(1000,
	    :ip                => request.remote_ip,
	    :return_url        => new_transaction_url,
	    :cancel_return_url => show_url
	  )
	  redirect_to EXPRESS_GATEWAY.redirect_url_for(response.token)
	end

	def new_transaction
	  @transaction = CTTransaction.new(:express_token => params[:token])
	end

	def create
	    @transaction = current_order.build_transaction_record(transaction_params)
	    @transaction.ip_address = request.remote_ip
	    if @transaction.save
		    if @transaction.purchase
		         render :text => "success"
		    else
		        render :action => "failure"
		    end
	    else
	      render :action => 'new'
    	end
	end

  def transaction_params
    params.require(:transaction).permit( :express_token)
  end
end

#
# Copyright 2017 EduRecords Education Services Pvt Ltd.
#
# Licensed under the Affero General Public License AGPL v3 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# https://www.gnu.org/licenses/agpl-3.0.html
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

class PaymentsController < ApplicationController
	skip_before_filter :verify_authenticity_token, only: [:dataForm, :ccavRequestHandler, :ccavResponseHandler, :paypalResponseHandler]
	require 'crypto'
	before_action :authenticate_user!, only: [:dataForm, :paypalRequestHandler], :raise => false

	def dataForm
		@order_id = params[:order_id]
		@total = params[:total]
		session[:order_id] = @order_id

    @order = Order.where(:id => @order_id).first
    @order.user_id = current_user.id
    @order.payment_status = "Cart"
    @order.save!


	end

	def ccavRequestHandler
		#binding.pry
	end

	def ccavResponseHandler
      workingKey="5C08131DBEE7990F7F48392F6FB34A37"#Put in the 32 Bit Working Key provided by CCAVENUES.   
	  encResponse=params[:encResp]
	  crypto = Crypto.new 
	  decResp=crypto.decrypt(encResponse,workingKey)
	  decResp = decResp.split("&")



		@transaction = CTTransaction.new
		@transaction.payment_gateway = "CCAvenue"
		@options = Hash.new
		decResp.each do |key|
			k = key.from(0).to(key.index("=")-1)
			v = key.from(key.index("=")+1).to(-1)
			@options[k] = v
    end
    @transaction.save!

    @order_id = @options['order_id']
    @order = Order.where(:id => @order_id).first
    @order.payment_status = @options['order_status']    # Success, Failure, Aborted, Invalid
    if @order.payment_status == 'Success'
      @order.fulfillment_status = 'New'
    end
    @order.save!

    @transaction.new_transaction(@options)
		@transaction.order_id = @options['order_id']
		@transaction.order_status = @options['order_status']
		@transaction.ip_address = request.remote_ip
		@transaction.first_name = @options['billing_name']
		@transaction.save!

		binding.pry

    redirect_to '/status'

  end

	def paypalRequestHandler
		@order_id = params[:order_id]
		@total = params[:total]
		@order = Order.where(:id => @order_id).first
    @order.user_id = current_user.id
    @order.payment_status = "Cart"
    @order.save!


    redirect_to @order.paypal_url(root_url, "https://yourdomainhere.localtunnel.me/paypalResponseHandler")
	end

=begin
	{"mc_gross"=>"100.02", "invoice"=>"439-407-491", "protection_eligibility"=>"Ineligible", "address_status"=>"unconfirmed",
	 "item_number1"=>"60", "payer_id"=>"YU82CTRXASE5J", "tax"=>"0.00",
	 "address_street"=>"Flat no. 507 Wing A Raheja Residency\r\nFilm City Road, Goregaon East",
	 "payment_date"=>"01:53:14 Jan 09, 2017 PST", "payment_status"=>"Pending", "charset"=>"windows-1252",
	 "address_zip"=>"400097", "mc_shipping"=>"0.00", "mc_handling"=>"0.00", "first_name"=>"test", "address_country_code"=>"IN",
	 "address_name"=>"test facilitator's Test Store", "notify_version"=>"3.8", "custom"=>"", "payer_status"=>"verified",
	 "address_country"=>"India", "num_cart_items"=>"1", "mc_handling1"=>"0.00", "address_city"=>"Mumbai",
	 "verify_sign"=>"A6Fyo.RG2CmUHAdbJ1HeGZnSj3AWA2005Oid0ZdIKcwRddome8tHRv38",
	 "payer_email"=>"ctpayments-facilitator@cleartranscripts.com", "mc_shipping1"=>"0.00", "tax1"=>"0.00",
	 "txn_id"=>"1D145917K4738884G", "payment_type"=>"instant",
	 "payer_business_name"=>"test facilitator's Test Store", "last_name"=>"facilitator", "address_state"=>"Maharashtra",
	 "item_name1"=>"Order: #439-407-491", "receiver_email"=>"ctpayments@cleartranscripts.com", "quantity1"=>"1",
	 "pending_reason"=>"unilateral", "txn_type"=>"cart", "mc_gross_1"=>"100.02", "mc_currency"=>"USD",
	 "residence_country"=>"IN", "test_ipn"=>"1", "transaction_subject"=>"", "payment_gross"=>"100.02",
	 "ipn_track_id"=>"12a3f93f74a44", "controller"=>"payments",
	 "action"=>"paypalResponseHandler"} permitted: false>

   Payment Status Values:
    Canceled_Reversal: A reversal has been canceled. For example, you won a dispute with the customer, and the funds for the transaction that was reversed have been returned to you.
    Completed: The payment has been completed, and the funds have been added successfully to your account balance.
    Created: A German ELV payment is made using Express Checkout.
    Denied: You denied the payment. This happens only if the payment was previously pending because of possible reasons described for the pending_reason variable or the Fraud_Management_Filters_x variable.
    Expired: This authorization has expired and cannot be captured.
    Failed: The payment has failed. This happens only if the payment was made from your customer’s bank account.
    Pending: The payment is pending. See pending_reason for more information.
    Refunded: You refunded the payment.
    Reversed: A payment was reversed due to a chargeback or other type of reversal. The funds have been removed from your account balance and returned to the buyer. The reason for the reversal is specified in the ReasonCode element.
    Processed: A payment has been accepted.
    Voided: This authorization has been voided.
=end

  def paypalResponseHandler
    binding.pry
    @transaction = CTTransaction.new
    @transaction.payment_gateway = "PayPal"
    @options = Hash.new
    params.each do |k,v|
      @options[k] = v
    end
    @transaction.save!


    @order_id = @options['invoice']
    @order = Order.where(:id => @order_id).first
    case @options['payment_status']
      when 'Canceled_Reversal'
      when 'Completed'
        @order.fulfillment_status = 'New'
        @order.payment_status = 'Success'
      when 'Created'
      when 'Denied'
      when 'Expired'
      when 'Failed'
      when 'Refunded'
      when 'Reversed'
      when 'Voided'
        @order.payment_status = 'Failure'
      when 'Pending'
        @order.fulfillment_status = 'New'
        @order.payment_status = 'Pending'
      when 'Processed'
        @order.fulfillment_status = 'New'
        @order.payment_status = 'Success'
    end
    @order.save!

    @transaction.new_transaction(@options)
    @transaction.order_id = @order_id
    @transaction.order_status = @options['payment_status']
    @transaction.ip_address = request.remote_ip
    @transaction.first_name = @options['first_name']
    @transaction.last_name = @options['last_name']
    @transaction.save!

    #binding.pry

    redirect_to '/status'
  end
end

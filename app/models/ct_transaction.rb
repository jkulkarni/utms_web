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

class CTTransaction < ApplicationRecord
  belongs_to :order
  has_many :order_transactions
	has_one :cca_transaction, :foreign_key => :transaction_id, :class_name => 'CcaTransaction', :dependent => :destroy
	has_one :paypal_transaction, :foreign_key => :txn_id, :class_name => 'PaypalTransaction', :dependent => :destroy
	accepts_nested_attributes_for :cca_transaction
  accepts_nested_attributes_for :paypal_transaction


	def new_transaction(options = {})


			#self.payment_gateway = options['payment_gateway'] || 'CCAvenue'
			if payment_gateway == 'CCAvenue'
				self.build_cca_transaction
        self.cca_transaction.order_id = options['order_id'] || ''
        self.cca_transaction.tracking_id = options['tracking_id'] || ''
				self.cca_transaction.bank_ref_no = options['bank_ref_no'] || ''
				self.cca_transaction.order_status = options['order_status'] || ''
				self.cca_transaction.failure_message = options['failure_message'] || ''
				self.cca_transaction.payment_mode = options['payment_mode'] || ''
				self.cca_transaction.card_name = options['card_name'] || ''
				self.cca_transaction.status_code = options['status_code'] || ''
				self.cca_transaction.currency = options['currency'] || ''
				self.cca_transaction.amount = options['amount'] || 0
				self.cca_transaction.billing_name = options['billing_name'] || ''
				self.cca_transaction.billing_address = options['billing_address'] || ''
				self.cca_transaction.billing_city = options['billing_city'] || ''
				self.cca_transaction.billing_state  = options['billing_state'] || ''
				self.cca_transaction.billing_zip  = options['billing_zip'] || ''
				self.cca_transaction.billing_country = options['billing_country'] || ''
				self.cca_transaction.billing_tel  = options['billing_tel'] || ''
				self.cca_transaction.billing_email = options['billing_email'] || ''
				self.cca_transaction.delivery_name = options['delivery_name'] ||''
				self.cca_transaction.delivery_address= options['delivery_address'] ||''
				self.cca_transaction.delivery_city= options['delivery_city'] ||''
				self.cca_transaction.delivery_state = options['delivery_state'] ||''
				self.cca_transaction.delivery_zip = options['delivery_zip'] ||''
				self.cca_transaction.delivery_country = options['delivery_country'] ||''
				self.cca_transaction.delivery_tel = options['delivery_tel'] ||''
				self.cca_transaction.merchant_param1 = options['merchant_param1'] ||''
				self.cca_transaction.merchant_param2 = options['merchant_param2'] ||''
				self.cca_transaction.merchant_param3= options['merchant_param3'] ||''
				self.cca_transaction.merchant_param4= options['merchant_param4'] ||''
				self.cca_transaction.merchant_param5= options['merchant_param5'] ||''
				self.cca_transaction.vault= options['vault'] ||''
				self.cca_transaction.offer_type= options['offer_type'] ||''
				self.cca_transaction.offer_code= options['offer_code'] ||''
				self.cca_transaction.discount_value= options['discount_value'] ||''
				self.cca_transaction.mer_amount= options['mer_amount'] ||''
				self.cca_transaction.eci_value= options['eci_value'] ||''
				self.cca_transaction.retry= options['merchant_param1'] ||''
				self.cca_transaction.response_code= options['response_code'] ||''
				self.cca_transaction.billing_notes= options['billing_no'] ||''
				self.cca_transaction.trans_date= options['trans_date'] ||''
        self.cca_transaction.ct_transaction_id = self.id
        self.cca_transaction.save!
        self.save!

      elsif payment_gateway == 'PayPal'
        self.build_paypal_transaction
        self.paypal_transaction.tax = options['tax']
        self.paypal_transaction.txn_id = options['invoice']
        self.paypal_transaction.address_street = options['address_street']
        self.paypal_transaction.payment_date = options['payment_date']
        self.paypal_transaction.payment_status = options['payment_status']
        self.paypal_transaction.charset = options['charset']
        self.paypal_transaction.address_zip = options['address_zip']
        self.paypal_transaction.mc_shipping = options['mc_shipping']
        self.paypal_transaction.mc_handling = options['mc_handling']
        self.paypal_transaction.first_name = options['first_name']
        self.paypal_transaction.address_country_code = options['address_country_code']
        self.paypal_transaction.address_name = options['address_name']
        self.paypal_transaction.notify_version = options['notify_version']
        self.paypal_transaction.custom = options['custom']
        self.paypal_transaction.payer_status = options['payer_status']
        self.paypal_transaction.address_country = options['address_country']
        self.paypal_transaction.num_cart_item = options['num_cart_item']
        self.paypal_transaction.address_city = options['address_city']
        self.paypal_transaction.verify_sign = options['verify_sign']
        self.paypal_transaction.payer_email = options['payer_email']
        self.paypal_transaction.tax1 = options['tax1']
        self.paypal_transaction.payment_type = options['payment_type']
        self.paypal_transaction.payer_business_name = options['payer_business_name']
        self.paypal_transaction.last_name = options['last_name']
        self.paypal_transaction.address_state = options['address_state']
        self.paypal_transaction.item_name1 = options['item_name1']
        self.paypal_transaction.receiver_email = options['receiver_email']
        self.paypal_transaction.quantity1 = options['quantity1']
        self.paypal_transaction.pending_reason = options['pending_reason']
        self.paypal_transaction.txn_type = options['txn_type']
        self.paypal_transaction.mc_gross_1 = options['mc_gross_1']
        self.paypal_transaction.mc_currency = options['mc_currency']
        self.paypal_transaction.residence_country = options['residence_country']
        self.paypal_transaction.test_ipn = options['test_ipn']
        self.paypal_transaction.transaction_subject = options['transaction_subject']
        self.paypal_transaction.payment_gross = options['payment_gross']
        self.paypal_transaction.ipn_track_id = options['ipn_track_id']
        self.paypal_transaction.ct_transaction_id = self.id
        self.paypal_transaction.save!
        self.save!
      end


	end

	def purchase
	  response = EXPRESS_GATEWAY.purchase(1000, express_purchase_options)
	  order_transactions.create!(:action => "purchase", :amount => 1000, :response => response)
	  self.order.update_attribute(:purchased_at, Time.now) if response.success?
	  response.success?
	end

	def express_token=(token)
	  write_attribute(:express_token, token)
	  if new_record? && !token.blank?
	    details = EXPRESS_GATEWAY.details_for(token)
	    self.express_payer_id = details.payer_id
	    self.first_name = details.params["first_name"]
	    self.last_name = details.params["last_name"]
	  end
	end

  private
	def express_purchase_options
	  {
	    :ip => ip_address,
	    :token => express_token,
	    :payer_id => express_payer_id
	  }
	end
end



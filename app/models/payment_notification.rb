class PaymentNotification < ApplicationRecord
	belongs_to :order
	serialize :params
	after_create :mark_order_as_purchased

private
	def mark_order_as_purchased
	  if status == "Completed"
	  	binding.pry
	    order.update_attribute(:purchased_at, Time.now)
	  end
	end
end


# class PaymentNotification < ActiveRecord::Base
#   has_many :kv_entries, :foreign_key => :payment_notification_id, :class_name => 'KvEntry', :dependent => :destroy

#   def sync_instamojo_payments
#     # Some other code
#   end
#   # 5.minutes.from_now will be evaluated when in_the_future is called
#   # handle_asynchronously :sync_instamojo_payments, :run_at => Proc.new { 5.minutes.from_now }

# end

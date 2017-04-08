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

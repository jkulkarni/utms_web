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

class Order < ApplicationRecord
  belongs_to :order_status
  has_many :order_items, inverse_of: :order
  before_create :set_order_status, :set_order_id
  has_one :transaction_record, :class_name => "::CTTransaction"
  # before_save :update_subtotal

  def subtotal
    # order_items.collect { |oi| oi.valid? ? (oi.service_charge + oi.service_tax + oi.university_charge + oi.shipping) : 0 }.sum
    order_items.collect { |oi| oi.valid? ? oi.service_charge : 0 }.sum
  end
 
  def paypal_url(return_url, notify_url)
    values = {
      :business => 'ctpayments@cleartranscripts.com',
      :cmd => '_cart',
      :upload => 1,
      :return => return_url,
      :invoice => id, #Order_id exact to be sent for update of purchased_at by IPN
      :notify_url => notify_url
    }
    order_items.each_with_index do |item, index|
      values.merge!({
        "amount_#{index+1}" => (GoogCurrency.inr_to_usd(item.transcript_application.total.to_i)).round(2),
        "item_name_#{index+1}" => "Order: #" + order_id.to_s,
        "item_number_#{index+1}" => item.transcript_application.id,
        "quantity_#{index+1}" => item.transcript_application.quantity
      })
    end
    "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
  end

private
  def set_order_status
    self.order_status_id = 1
  end

  def update_subtotal
    self[:subtotal] = subtotal
  end

  def set_order_id
    # n = SecureRandom.random_number(1000000000)
    # self.order_id = n.to_s.reverse.gsub(/...(?=.)/,'\&-').reverse 
  end
end
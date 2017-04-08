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

class PaypalIpnController < ApplicationController

  protect_from_forgery :except => [:listener]
  skip_before_filter  :authenticate_user!, only: [:listener], :raise => false

  def listener

    invoice_id = nil
    #binding.pry

    response = validate_IPN_notification(request.raw_post)
    case response
      when 'VERIFIED'
        if params['txn_id']
          payment = PaymentNotification.where(:txn_id => params['txn_id']).first
          if !payment.nil?
            render :nothing => true
            return
          end

        end


        payment_notification = PaymentNotification.new(
            :payment_gateway => 'PayPal',
            :txn_id => params['txn_id'],
            :ponumber => ponumber,
            :amount => params['payment_gross'] || params['mc_gross'],
            :invoice_id => invoice_id || 0

        )

        params.each do |key, value|
          kv_entry = KvEntry.new(:key => key, :value => value)
          kv_entry.save!

          payment_notification.kv_entries << kv_entry
        end

        #TBD Transcript Application Status Update


        payment_notification.save!


      when 'INVALID'
      else
    end
    render :nothing => true
  end

  protected
  def validate_IPN_notification(raw)
    prod_url = 'https://www.paypal.com/cgi-bin/webscr?cmd=_notify-validate'
    sandbox_url = 'https://ipnpb.sandbox.paypal.com/cgi-bin/webscr?cmd=_notify-validate'
    uri = URI.parse(prod_url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.open_timeout = 60
    http.read_timeout = 60
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    http.use_ssl = true
    #binding.pry
    response = http.post(uri.request_uri, raw,
                         'Content-Length' => '#{raw.size}',
                         'User-Agent' => 'utms').body

  end

end



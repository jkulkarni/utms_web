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

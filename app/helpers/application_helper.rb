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

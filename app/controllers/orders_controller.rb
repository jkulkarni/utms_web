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

class OrdersController < ApplicationController
  before_filter :check_for_mobile, :only => [:show]
  skip_before_filter :verify_authenticity_token, only:[:application_status2]
  before_action :authenticate_user!, only: [:application_status, :application_status2]



  def show
  # binding.pry
  @coupon_code = params.permit(:coupon)[:coupon] if params.permit( :coupon)[:coupon].present?
  currency = params.permit( :currency)[:currency] if params.permit( :currency)[:currency].present?
	@current_currency = currency.present? ? currency : "INR"
  @order = current_order
  #binding.pry
  
  @order_id = current_order.id
  @order_items = current_order.order_items.includes(:transcript_application)
	@items = @order_items.count
=begin
  	if currency == "PAY IN USD"
      inr
    elsif currency == "PAY IN INR"
      usd
  	end
=end
    @total_array = @order_items.map{ |sum| sum.transcript_application.total.to_i }
    @total = @total_array.inject(0){|sum,x| sum + x }
    if @coupon_code.present? && current_order.coupon_applied == false
      coupon
    end
    current_order.total = @total.to_i
    if current_order.coupon_applied == true
      current_order.total = @discounted_total
    end
    current_order.save

    
  end


  def application_status
    #binding.pry
    unless current_user.nil?
      @orders = Order.where(:user_id => current_user.id)
    else
      if session[:order_id]
        @orders = Order.where(:id => session[:order_id])
      end
    end

    @countries = Country.all

  end

  def application_status2
    #binding.pry
    unless current_user.nil?
      @orders = Order.where(:user_id => current_user.id)
    else
      if session[:order_id]
        @orders = Order.where(:id => session[:order_id])
      end
    end

    @countries = Country.all

    render 'application_status'
  end

private
  def dollar
  	@rupees = GoogCurrency.usd_to_inr(1)
  end

  def inr
    dollar
      @order_items.each do |change_currency_values|
        if change_currency_values.transcript_application.currency == "INR"
          change_currency_values.transcript_application.currency = "USD"
          change_currency_values.transcript_application.service_charge = (change_currency_values.transcript_application.service_charge/@rupees) 
          change_currency_values.transcript_application.service_tax = (change_currency_values.transcript_application.service_tax/@rupees) 
          change_currency_values.transcript_application.shippingFee = (change_currency_values.transcript_application.shippingFee/@rupees) 
          change_currency_values.transcript_application.total = (change_currency_values.transcript_application.total/@rupees) 
          change_currency_values.transcript_application.save
        end
      end
  end


  def usd
    dollar
      @order_items.each do |change_currency_values|
        if change_currency_values.transcript_application.currency == "USD"
          change_currency_values.transcript_application.currency = "INR"
          change_currency_values.transcript_application.service_charge = (change_currency_values.transcript_application.service_charge*@rupees).round 
          change_currency_values.transcript_application.service_tax = (change_currency_values.transcript_application.service_tax*@rupees).round 
          change_currency_values.transcript_application.shippingFee = (change_currency_values.transcript_application.shippingFee*@rupees).round 
          change_currency_values.transcript_application.total = (change_currency_values.transcript_application.total*@rupees).round 
          change_currency_values.transcript_application.save
        end
      end
  end

  def coupon
    coupon = Coupon.where(:coupon_code => @coupon_code)
    if coupon.present?
      discount = coupon.first.discount
      @discount = (@total*discount)/100 unless discount.nil?
      current_order.coupon_applied = true
      current_order.coupon_applied = true
      @discounted_total = @total - @discount 
    end
  end
end

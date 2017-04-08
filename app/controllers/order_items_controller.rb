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

class OrderItemsController < ApplicationController

  def create
    @order = current_order
    @order_item = @order.order_items.new(order_item_params)
    @order.save
    session[:order_id] = @order.id
  end

  def update
    @order = current_order
    quantity = copies =  params[:order_item][:quantity].to_i
    transcript_application_id = params[:id]
    @transcript_application = TranscriptApplication.where(:id => transcript_application_id ).first
    @transcript_application[:university_id] .present? ? @university_detail = UniversityDetail.where(:id => @transcript_application[:university_id]).first :  @university_detail = UniversityDetail.where(:id => 1).first
    fromYear = @transcript_application.enrollment_year.year.to_i
    toYear = @transcript_application.completion_year.year.to_i

    # Use new quantity
    # quantity = copies ||= @transcript_application[:quantity].present? ? @transcript_application[:quantity].to_i : 0
    course = @transcript_application[:course_id] unless @transcript_application[:course_id].blank?
    college = College.where(:id => @transcript_application[:college_id] ) unless @transcript_application[:college_id].blank?
    # Get clarification for numofmarksheets
    numofmarksheets = 10
    college.present? ? autonomousCollege = college.first.autonomous_college : autonomousCollege = false
    college.present? ? outsideCollege = college.first.outsideCollege : outsideCollege = false

    @processingWeeks = eval(@university_detail.processingWeeks)
    @service_days =  eval(@university_detail.serviceDays)
    @service_charge = @service_days * 3100
    @service_tax = percent @service_charge, 0.15
    numberOfYears = eval(@university_detail.numberOfYears).abs
    cmm_charges = @university_detail.CMMcharges.nil? ? 0 : eval(@university_detail.CMMcharges)
    penaltyFee = @university_detail.penaltyFee.nil? ? 0 : eval(@university_detail.penaltyFee)
    searchFee = @university_detail.searchFee.present? ? eval(@university_detail.searchFee) : 0
    @ddAmount = eval(@university_detail.university_charge)

    weight = @university_detail.weight
    total_weight = weight * quantity
    weight_round_off = (total_weight + 50) / 100 * 100
    if WeightCategory.where(:weight_range_start => weight_round_off).present?
    weight_category_id = WeightCategory.where(:weight_range_start => weight_round_off).first.id
    end

    info_arr = []
    shippingFee_array = []

    info_arr = ShippingAddress.where(:transcript_application_id => @transcript_application.id)
    if info_arr
      info_arr.length.times do |i|
        country_id = info_arr[i][:country_id]
        # correct to ensure shippingFee is never zero
        shipping_charge = ShippingFee.where(:country_id => country_id, :weight_category_id => weight_category_id).present? ? ShippingFee.where(:country_id => country_id, :weight_category_id => weight_category_id).first.shipping_charge : 0
        shippingFee_array.push(shipping_charge)
      end
    end
    @shippingFee = shippingFee_array.inject(0){|sum,x| sum + x }
    @total = @service_charge + @service_tax + @ddAmount + @shippingFee

    # update application
     @transcript_application.quantity = quantity
     @transcript_application.processingWeeks = @processingWeeks
     @transcript_application.service_days = @service_days
     @transcript_application.service_charge = @service_charge
     @transcript_application.service_tax = @service_tax
     @transcript_application.university_charge = @ddAmount
     @transcript_application.shippingFee = @shippingFee
     @transcript_application.total = @total
     @transcript_application.save
     @order_items = current_order.order_items.includes(:transcript_application)
  end

  def delete_order
    @order = current_order
    @order_item = @order.order_items.find(params[:id])
    if !@order_item.nil?
      @order_item.destroy
      @order_items = @order.order_items
    else
      Rails.logger.error "Error could not delete the order " + params[:id]
    end


    text = '{"response": {"count": "' + @order.order_items.size.to_s + '"}}'
    #binding.pry
    #render plain: text

    @order_items = @order.order_items
    redirect_to show_path
  end

  def destroy
    @order = current_order
    @order_item = @order.order_items.find(params[:id])
    @order_item.destroy
    @order_items = @order.order_items
    redirect_to show_path 
  end

private
  def order_item_params
    params.require(:order_item).permit(:quantity, :order)
  end



  def percent(num, per)
    (per*num).round(2)
  end
end

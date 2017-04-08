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

class TranscriptApplicationsController < ApplicationController
# Render mobile or desktop depending on User-Agent for these actions.

  # Always render mobile versions for these, regardless of User-Agent.
    before_filter :check_for_mobile, :only => [:about_us]


  def index
    if session[:order_id]
      @order = Order.where(:id => session[:order_id]).first
    end

  end

  def create_transcript_application
    # binding.pry
    @transcript_application_new = TranscriptApplication.new
    #@transcript_application_new.university_charge = @university_charge
    #@transcript_application_new.service_days = @service_days
    #@transcript_application_new.service_charge = @service_charge
    #@transcript_application_new.service_tax = @service_tax
    #@transcript_application_new.shippingFee = @shippingFee
    #@transcript_application_new.total = @total
    @transcript_application_new.university_id = @_University.id
    @transcript_application_new.university_name = @_University.name
    #if @transcript_application_new.update_attributes(transcript_application_params)

      @transcript_application_new.update_attributes(transcript_application_params)
      @transcript_application_new.university_charge = transcript_application_params[:university_charge].to_i
      @transcript_application_new.service_charge = transcript_application_params[:service_charge].to_i
      @transcript_application_new.service_tax = transcript_application_params[:service_tax].to_i
      @transcript_application_new.shippingFee = transcript_application_params[:shippingFee].to_i
      @transcript_application_new.total = transcript_application_params[:total].to_i

      @transcript_application_new.save!

      order_handling
    #end
    true
  end

  def order_handling
    #binding.pry
    @order = current_order
    @order_item = @order.order_items.new
    @order_item.transcript_application_id = @transcript_application_new.id
      @order.save  unless @order.id.present?
    @order_item.save unless @order_item.id.present?
    set_session
  end

  def new
    if session[:order_id]
      @order = Order.where(:id => session[:order_id]).first
    end

    unless @_University.nil?
      #binding.pry

      @university = @_University
      @university_detail = UniversityDetail.where(:university_id => @_University.id).first

      @transcript_application = TranscriptApplication.new(:university_id=> @_University.id)
      @transcript_application.shipping_addresses.build
      values_location @_University.id
    else
      return redirect_to root_path
    end
  end

  def transcript_applications
    #binding.pry


    #values_location @_University.id
    create_transcript_application
    redirect_to show_path
  end

  def values_location(university_id)
    if @_University.nil?
      return redirect_to root_path
    end

    @university_detail = @_University.university_detail
    unless @university_detail.nil?
      @service_charge = @university_detail.service_charge
      @service_tax = (percent @university_detail.service_charge, 0.15).round
      discount = @university_detail.discount||0

      @discount = (discount == 0 ) ? 0 : (percent @university_detail.service_charge, discount/100.00)
      if params[:transcript_application].present?
        shippingAmount
      end
      @shippingFee = @shipfee || 150
      @total = (@service_charge - @discount + @service_tax + @shippingFee).round

    end

=begin
    @location = Location.where(:id => session[:location])
    @service_days = @location.first.service_days
    @service_charge = @service_days * 3100 
    @service_tax = (percent @service_charge, 0.15).round
    @discount = percent @service_charge, @location.first.discount/100.00  
    if params[:transcript_application].present?
      shippingAmount
    end
    @shippingFee = @shipfee || 150 
    @total = (@service_charge - @discount + @service_tax + @shippingFee).round
=end

  end

  def shippingAmount
   # Here I just initialize an empty array for later use
   info_arr = []
   #First I check that the targeted params exist (I had this need for my app)
   if params[:transcript_application][:shipping_addresses_attributes].present? 
       #z variable will tell me how many attributes are to be saved
       z = params[:transcript_application][:shipping_addresses_attributes].keys.count
       x = 0
       #Initiate loop to go through each of the attribute to be saved
       while x < z
           #Get the key (remember the number from above) of the first hash (params) attribute
           key = params[:transcript_application][:shipping_addresses_attributes].keys[x]
           #use that key to get the content of the attribtue
          value = params[:transcript_application][:shipping_addresses_attributes][key]
          #push the content to an array (I had to do this for my project)
           info_arr.push(value)
           #Through the loop you can perform actions to each single attribute
           #In my case, for each attributes I creates a new information association with recipe
           x = x +1
       end
    end 
    shippingFee_array = []  
    info_arr.length.times do |i|
      country_id = info_arr[i][:country_id]
      # correct to ensure shippingFee is never zero
      shipping_charge = ShippingFee.where(:country_id => country_id).present? ? ShippingFee.where(:country_id => country_id).first.shipping_charge : 0
      shippingFee_array.push(shipping_charge)
    end
    @shipfee = shippingFee_array.inject(0){|sum,x| sum + x }
  end

  def update_transcript_applications
    values_location @_University.id
    respond_to do |format|
      format.js
    end
  end

  def states_by_country

    country_id = params[:term]

    countries = Country.where(:country_id => country_id).pluck(:name)

    #binding.pry


  end

  def autofill
    autofill_key = params[:term]
    autofill = AutofillAddress.where(:key => autofill_key).first

    #binding.pry

    json_str = ''
    if !autofill.nil?
      json_str = '{"result": "success", "address": { "name" : "'
      json_str << autofill.name + '", "address_line1" : "'
      json_str << autofill.address_line1 + '", "address_line2" : "'
      json_str << autofill.address_line2 + '", "city" : "'
      json_str << autofill.city + '", "state_province_region" : "'
      json_str << autofill.state_province_region + '", "country_id" : "'
      json_str << autofill.country_id.to_s + '", "zip_or_postal_code" : "'
      json_str << autofill.zip_or_postal_code + '" }}'
    else
      json_str = '"result": "error"'
    end

    render plain: json_str.html_safe
  end

  def institute_names
    term = params[:term]
    @search_results
    @universities = Array.new

    unless term.blank?
      @search_results = University.where('lower(name) LIKE  ?', ('%'+term+'%').downcase )
      @search_results.each do |result|
        @universities << { :id => result.id, :label => result.name, :value => result.name}
      end
    end

    render json: @universities, :callback => params['callback']
  end

  def boolean_form_fields_required
    @form_fields_required = @university_detail.boolean_form_fields_required
  end

  private
  def set_values
  end

  def set_session
    if session[:order_id].nil?   
    session[:order_id] = @order.id 
    end 
  end


  def reset
    reset_session
    redirect_to root_path
  end

  def to_boolean(str)
    if str == "1" || str == "true"
      true
    else
      false
    end    
  end

  def percent(num, per)
    (per*num).round(2)
  end

  def create
    @transcript_application_new = TranscriptApplication.new
    @transcript_application_new.processingWeeks = @processingWeeks
    @transcript_application_new.service_days = @service_days
    @transcript_application_new.university_charge = @ddAmount
    @transcript_application_new.service_charge = @service_charge
    @transcript_application_new.service_tax = @service_tax
    @transcript_application_new.shippingFee = @shippingFee
    @transcript_application_new.total = @total
    if @transcript_application_new.update_attributes(transcript_application_params)
      order_handling
    end
    true
  end

  def values
    @transcript_application ||= transcript_application_params
    @transcript_application[:university_id] .present? ? @university_detail = UniversityDetail.where(:id => @transcript_application[:university_id]).first :  @university_detail = UniversityDetail.where(:id => 1).first
    fromYear ||= @transcript_application[:"enrollment_year(1i)"].to_i 
    toYear ||= @transcript_application[:"completion_year(1i)"].to_i
    course ||= @transcript_application[:course_id] unless @transcript_application[:course_id].blank?
    quantity = copies ||= @transcript_application[:quantity].present? ? @transcript_application[:quantity].to_i : 0
    college ||= College.where(:id => @transcript_application[:college_id] ) unless @transcript_application[:college_id].blank?
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

    # Set boolean flags
    @nri = @university_detail.nri 
    @foriegnNational = @university_detail.foreign_national
    @studiedAbroad = @university_detail.studied_abroad
    @consolidatedMemo = @university_detail.consolidated_memo 
    @degreecertificate = @university_detail.degree_certificate
    @wesForm = @university_detail.wes_form
    @syllabusRequired =@university_detail.syllabus_required

    weight = @university_detail.weight
    total_weight = weight * quantity
    weight_round_off = (total_weight + 50) / 100 * 100
    # weight_category_id = WeightCategory.where(:weight_range_start => weight_round_off).first.id
    #Here I just initialize an empty array for later use
    info_arr = []
    #First I check that the targeted params exist (I had this need for my app) 
    if not @transcript_application[:shipping_addresses_attributes].nil?
        #z variable will tell me how many attributes are to be saved
        z = @transcript_application[:shipping_addresses_attributes].keys.count
        x = 0
        #Initiate loop to go through each of the attribute to be saved
        while x < z
            #Get the key (remember the number from above) of the first hash (params) attribute
            key = @transcript_application[:shipping_addresses_attributes].keys[x]
            #use that key to get the content of the attribtue
            value = @transcript_application[:shipping_addresses_attributes][key]
            #push the content to an array (I had to do this for my project)
            info_arr.push(value)
            #Through the loop you can perform actions to each single attribute
            #In my case, for each attributes I creates a new information association with recipe
            x = x +1
        end
    end 
    # shippingFee_array = []  
    # info_arr.length.times do |i|
    #   country_id = info_arr[i][:country_id]
      # correct to ensure shippingFee is never zero
      # shipping_charge = ShippingFee.where(:country_id => country_id, :weight_category_id => weight_category_id).present? ? ShippingFee.where(:country_id => country_id, :weight_category_id => weight_category_id).first.shipping_charge : 0
      # shippingFee_array.push(shipping_charge)
    # end
    # @shippingFee = shippingFee_array.inject(0){|sum,x| sum + x }
    # @total = @service_charge + @service_tax + @ddAmount + @shippingFee
  end

    def transcript_application_params
      params.require(:transcript_application).permit( :location_id, :student_name, :college_name, :course_name, :university_name,
                                                      :register_number, :enrollment_year, :completion_year, :no_of_sets,
                                                      :campus, :delivery_partner, :quantity, :ndocs, :nri,
                                                      :foriegnNational, :studiedAbroad, :consolidatedMemo,
                                                      :degreecertificate, :wesForm, :syllabusRequired,
                                                      :university_charge, :service_charge, :service_tax, :shippingFee, :total,
                                                      shipping_addresses_attributes: [ :id, :autofill_address, :no_of_sets, :name, :address_line1, :address_line2, :city, :state_province_region,:zip_or_postal_code, :country_id, :_destroy ])
    end

end
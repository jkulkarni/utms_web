class OrderItem < ActiveRecord::Base
  belongs_to :transcript_application, inverse_of: :order_item
  belongs_to :order

  # validates :service_charge, presence: true
  # validate :transcript_application_present
  # validate :order_present

  # before_save :finalize

  def service_charge
    if persisted?
      self[:service_charge]
    else
      transcript_application.service_charge
    end
  end  

  # def service_tax
  #   if persisted?
  #     self[:service_tax]
  #   else
  #     transcript_application.service_tax
  #   end
  # end  

  # def shipping
  #   if persisted?
  #     self[:shipping]
  #   else
  #     transcript_application.shipping
  #   end
  # end

  # def university_charge
  #   if persisted?
  #     self[:university_charge]
  #   else
  #     transcript_application.university_charge
  #   end
  # end

  def total_price
    # service_charge + service_tax + university_charge + shipping
    service_charge 
  end

private
  def transcript_application_present
    if transcript_application.nil?
      errors.add(:transcript_application, "is not valid or is not present.")
    end
  end

  def order_present
    if order.nil?
      errors.add(:order, "is not a valid order.")
    end
  end

  def finalize
    self[:service_charge] = service_charge
    # self[:service_tax] = service_tax
    # self[:university_charge] = university_charge
    # self[:shipping] = shipping
    self[:total_price] =  self[:service_charge]
    # self[:total_price] =  self[:service_charge] + self[:service_charge] + self[:service_tax] + self[:university_charge] + self[:shipping]
  end
  
end
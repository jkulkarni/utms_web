class ShippingAddress < ApplicationRecord
	belongs_to :transcript_application
	has_one :country
end

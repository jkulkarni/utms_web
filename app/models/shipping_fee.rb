class ShippingFee < ApplicationRecord
	has_one :weight_category
	has_one :country
end

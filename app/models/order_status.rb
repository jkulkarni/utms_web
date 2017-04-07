class OrderStatus < ApplicationRecord
	has_many :orders, inverse_of: :order_status
end

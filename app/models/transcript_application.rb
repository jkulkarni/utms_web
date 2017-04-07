class TranscriptApplication < ApplicationRecord
	has_many :order_item, inverse_of: :transcript_application
	belongs_to :course
	belongs_to :university
	belongs_to :college
	has_many :shipping_addresses
	accepts_nested_attributes_for :shipping_addresses
	has_many :shipping_fees
	belongs_to :location
#	validates :college_name, presence: true
	validates :course_name, presence: true
#	validates :university_name, presence: true
#	validates :register_number, presence: true
#	validates :enrollment_year, presence: true
#	validates :completion_year, presence: true
end


class College < ApplicationRecord
	has_many :transcript_applications, inverse_of: :college
	belongs_to :university
end

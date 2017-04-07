class University < ApplicationRecord
	has_many :transcript_applications, inverse_of: :university
	has_many :colleges
	has_one :university_detail
end
	
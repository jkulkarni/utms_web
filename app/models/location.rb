class Location < ApplicationRecord
	has_many :transcript_applications, inverse_of: :university
end

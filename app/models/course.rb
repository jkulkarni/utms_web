class Course < ApplicationRecord
	has_many :transcript_applications, inverse_of: :course
end

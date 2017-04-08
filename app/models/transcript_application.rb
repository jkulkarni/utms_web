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


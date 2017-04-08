=begin
Copyright 2017 EduRecords Education Services Pvt Ltd.

Licensed under the Affero General Public License AGPL v3 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

https://www.gnu.org/licenses/agpl-3.0.html

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
=end

ActiveAdmin.register TranscriptApplication do
  decorate_with ShippingAddressDecorator
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
  controller do
    def get_country (country_id)
      Country.where(country_id: country_id).pluck(:name).first!
    end
  end

  index do
    id_column
    column :created_at
    column :student_name
    column :university_name
    column :total
  end

  show do
      tabs do
        tab 'Transcript Applications' do
          attributes_table do
            row(:location_id) {Location.where(:id => transcript_application.location_id).pluck(:name).first}
            row(:university_name) {transcript_application.university_name}
            row(:student_name) {transcript_application.student_name}
            row(:college_name) {transcript_application.college_name}
            row(:course_name) {transcript_application.course_name}
            row(:quantity) {transcript_application.quantity}
            row(:ndocs) {transcript_application.ndocs}
            row(:enrollment_year) {transcript_application.enrollment_year}
            row(:completion_year) {transcript_application.completion_year}
            row(:service_charge) {transcript_application.service_charge}
            row(:service_tax) {transcript_application.service_tax}
            row(:shippingFee) {transcript_application.shippingFee}
            row(:total) {transcript_application.total}

          end

        end


        tab 'Shipping Addresses' do
          table_for transcript_application.shipping_addresses do
            column('Number of sets', :no_of_sets)
            column('Name', :name)
            column('Address Line1', :address_line1)
            column('Address Line2', :address_line2)
            column('City', :city)
            column('State', :state)
            column('Zip code', :zip_or_postal_code)
            column('Country', :country_name)
            column('Phone', :phone)
          end
        end
      end
  end

end

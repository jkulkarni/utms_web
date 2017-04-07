class CreateUniversityDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :university_details do |t|
# For streamlining query
   t.integer :university_code
   t.integer :university_id, index: true, index: true

# For serviceDays calculation
	t.string :name
	t.string :serviceDays
	t.string :processingWeeks
	t.text :universityNotes
	t.text :packetContents

# For ddAmount calculation
	t.string  :type	
	# Use name field instead
	t.string  :ddName
	t.string  :officeAddress
	t.decimal :discount
	t.string :numberOfYears
	# Time.now.year - completionyear - 3
	t.string  :CMMcharges
	# Available options
	# numberOfYears * X * Y
	# numberOfYears * numofmarksheets * X(Integer value)
	# numberOfYears + numofmarksheets * X(Integer value)
	# numberOfYears * X(Integer value)
	# numberOfmarksheets + X(Integer value)
	# Any combinationwith two variables above
	t.string  :penaltyFee 	
	# Available options
	# numberOfYears * numofmarksheets * X(Integer value)
	# numberOfYears + numofmarksheets * X(Integer value)
	# numberOfYears * X(Integer value)
	# numberOfmarksheets + X(Integer value)
	# Any combinationwith two variables above
	t.text  :shippingaddress
	# if shippingAddress.upcase.include? "CANADA"
	#   ddAmount += 1060
	# elsif shippingAddress.upcase.include? "INDIA"
	#   ddAmount += 100
	# elsif shippingAddress.upcase.include? "UNITED STATES"
	#   ddAmount += 700
	# else
	#   ddAmount = 1000
	# end
	t.string :searchFee
	# searchFee = 0
	# if numberOfYears > 10
	#   searchFee = 750
	# elsif numberOfYears > 3
	#   searchFee = 400
	# else
	#   searchFee = 200
	# end
	t.string :university_charge
	# copies * 3000
	# copies * 3000 + 1000
	# (numofmarksheets * 675) + (copies.to_i-1 * (numofmarksheets*615*0.1))
	# completionyear
	# numofmarksheets
	t.boolean :nri, :default => false
	t.boolean :foreign_national, :default => false
	t.boolean :studied_abroad, :default => false
	t.boolean :consolidated_memo, :default => false
	t.boolean :degree_certificate, :default => false
	t.boolean :wes_form, :default => false
	t.boolean :syllabus_required, :default => false
	t.integer :weight
	
    t.timestamps null: false
    end
  end
end
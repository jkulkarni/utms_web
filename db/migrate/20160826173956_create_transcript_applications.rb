class CreateTranscriptApplications < ActiveRecord::Migration[5.0]
  def change
    create_table :transcript_applications do |t|
      t.integer :user_id, index: true, index: true
      t.integer :location_id, index: true, index: true
      t.string :university_name
      t.string :college_name
      t.string :course_name
      t.string :register_number
      t.string :register_number
      t.date :enrollment_year
      t.date :completion_year
      t.string :delivery_partner
      # t.boolean :xerox_requested
      # t.string :transcript_type
      # t.date :process_completion_date
      # FIELDS FOR SERVICE CHARGE 
      t.string :ndocs
      t.integer :quantity #alias for qty
      t.boolean :nri
      t.boolean :foriegnNational
      t.boolean :studiedAbroad
      t.boolean :consolidatedMemo
      t.string :shippingAddress_sets1
      t.string :shippingAddress_country1
      t.string :shippingAddress_sets2
      t.string :shippingAddress_country2
      t.string :degreecertificate
      t.string :universityNotes
      t.string :packetContents
      t.string :wesForm
      t.string :syllabusRequired
      t.string :campus # ASK ONLY FOR DU
      t.string :selectOutreachOption
      t.string :remark
      # Update below fields name as required later
      t.integer :processingWeeks
      t.string :eta
      t.integer :service_days
      t.decimal :university_charge, :precision => 15, :scale => 2
      t.integer :discount_coupon_code
      t.boolean :coupon_applied, :default => false
      t.decimal :service_charge, :precision => 15, :scale => 2
      t.decimal :service_tax, :precision => 15, :scale => 2
      t.decimal :shippingFee, :precision => 15, :scale => 2
      t.decimal :total, :precision => 15, :scale => 2
      t.string :currency, :default => "INR"

      t.timestamps null: false
    end
  end
end
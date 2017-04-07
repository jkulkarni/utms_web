# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170317060329) do

  create_table "active_admin_comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "namespace"
    t.text     "body",          limit: 65535
    t.string   "resource_id",                 null: false
    t.string   "resource_type",               null: false
    t.string   "author_type"
    t.integer  "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree
  end

  create_table "admin_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.index ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "autofill_addresses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "name"
    t.string   "address_line1"
    t.string   "address_line2"
    t.string   "city"
    t.string   "state_province_region"
    t.string   "zip_or_postal_code"
    t.string   "phone"
    t.integer  "country_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "key"
  end

  create_table "cca_transactions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "bank_ref_no"
    t.string   "order_status"
    t.string   "failure_message"
    t.string   "payment_mode"
    t.string   "card_name"
    t.string   "status_code"
    t.string   "status_message"
    t.string   "currency"
    t.integer  "amount"
    t.string   "billing_name"
    t.string   "billing_address"
    t.string   "billing_city"
    t.string   "billing_state"
    t.string   "billing_zip"
    t.string   "billing_country"
    t.string   "billing_tel"
    t.string   "billing_email"
    t.string   "delivery_name"
    t.string   "delivery_address"
    t.string   "delivery_city"
    t.string   "delivery_state"
    t.string   "delivery_zip"
    t.string   "delivery_country"
    t.string   "delivery_tel"
    t.string   "merchant_param1"
    t.string   "merchant_param2"
    t.string   "merchant_param3"
    t.string   "merchant_param4"
    t.string   "merchant_param5"
    t.string   "vault"
    t.string   "offer_type"
    t.string   "offer_code"
    t.integer  "discount_value"
    t.integer  "mer_amount"
    t.string   "eci_value"
    t.string   "retry"
    t.string   "response_code"
    t.string   "billing_notes"
    t.string   "trans_date"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "transaction_id"
    t.string   "order_id"
    t.string   "tracking_id"
    t.integer  "ct_transaction_id"
    t.index ["ct_transaction_id"], name: "index_cca_transactions_on_ct_transaction_id", using: :btree
    t.index ["transaction_id"], name: "index_cca_transactions_on_transaction_id", using: :btree
  end

  create_table "cities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "city_id"
    t.string   "name"
    t.integer  "state_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "colleges", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "name"
    t.string   "code"
    t.string   "region"
    t.string   "city"
    t.string   "address"
    t.string   "contact"
    t.boolean  "outsideCollege"
    t.boolean  "autonomous_college"
    t.integer  "university_id"
    t.integer  "transcript_application_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["transcript_application_id"], name: "index_colleges_on_transcript_application_id", using: :btree
    t.index ["university_id"], name: "index_colleges_on_university_id", using: :btree
  end

  create_table "countries", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "name"
    t.string   "iso"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "sortname"
    t.integer  "country_id"
  end

  create_table "coupons", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "coupon_code"
    t.integer  "applicable_times"
    t.integer  "applied_times"
    t.integer  "discount"
    t.boolean  "applicable",        default: true
    t.date     "coupon_expires_on"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "courses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "name"
    t.integer  "transcript_application_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["transcript_application_id"], name: "index_courses_on_transcript_application_id", using: :btree
  end

  create_table "ct_transactions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "express_token"
    t.string   "express_payer_id"
    t.integer  "order_id"
    t.string   "ip_address"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "card_type"
    t.date     "card_expires_on"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "payment_gateway"
    t.string   "order_status"
    t.index ["order_id"], name: "index_transactions_on_order_id", using: :btree
  end

  create_table "kv_entries", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "key"
    t.string   "value"
    t.integer  "payment_notification_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["payment_notification_id"], name: "index_kv_entries_on_payment_notification_id", using: :btree
  end

  create_table "locations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "name"
    t.integer  "amount"
    t.integer  "service_days"
    t.integer  "discount"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "order_items", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "transcript_application_id"
    t.integer  "order_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["order_id"], name: "index_order_items_on_order_id", using: :btree
    t.index ["transcript_application_id"], name: "index_order_items_on_transcript_application_id", using: :btree
  end

  create_table "order_statuses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_transactions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "transaction_id"
    t.string   "action"
    t.integer  "amount"
    t.boolean  "success"
    t.string   "authorization"
    t.string   "message"
    t.text     "params",         limit: 65535
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "orders", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.decimal  "total",              precision: 12, scale: 3
    t.integer  "order_status_id"
    t.integer  "user_id"
    t.string   "currency",                                    default: "INR"
    t.string   "order_id"
    t.datetime "purchased_at"
    t.boolean  "coupon_applied",                              default: false
    t.datetime "created_at",                                                  null: false
    t.datetime "updated_at",                                                  null: false
    t.string   "payment_status"
    t.string   "fulfillment_status"
    t.index ["order_status_id"], name: "index_orders_on_order_status_id", using: :btree
    t.index ["user_id"], name: "index_orders_on_user_id", using: :btree
  end

  create_table "payment_notifications", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.text     "params",         limit: 65535
    t.integer  "order_id"
    t.string   "status"
    t.string   "transaction_id"
    t.string   "create"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "paypal_transactions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "order_id"
    t.float    "mc_gross",               limit: 24
    t.string   "protection_eligibility"
    t.string   "address_status"
    t.string   "item_number1"
    t.string   "payer_id"
    t.float    "tax",                    limit: 24
    t.string   "address_street"
    t.string   "payment_date"
    t.string   "payment_status"
    t.string   "charset"
    t.string   "address_zip"
    t.float    "mc_shipping",            limit: 24
    t.float    "mc_handling",            limit: 24
    t.string   "first_name"
    t.string   "address_country_code"
    t.string   "address_name"
    t.string   "notify_version"
    t.string   "custom"
    t.string   "payer_status"
    t.string   "address_country"
    t.integer  "num_cart_item"
    t.string   "address_city"
    t.string   "verify_sign"
    t.string   "payer_email"
    t.float    "tax1",                   limit: 24
    t.string   "txn_id"
    t.string   "payment_type"
    t.string   "payer_business_name"
    t.string   "last_name"
    t.string   "address_state"
    t.string   "item_name1"
    t.string   "receiver_email"
    t.integer  "quantity1"
    t.string   "pending_reason"
    t.string   "txn_type"
    t.float    "mc_gross_1",             limit: 24
    t.string   "mc_currency"
    t.string   "residence_country"
    t.integer  "test_ipn"
    t.string   "transaction_subject"
    t.float    "payment_gross",          limit: 24
    t.string   "ipn_track_id"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "transaction_id"
    t.integer  "ct_transaction_id"
    t.index ["ct_transaction_id"], name: "index_paypal_transactions_on_ct_transaction_id", using: :btree
    t.index ["txn_id"], name: "index_paypal_transactions_on_txn_id", unique: true, using: :btree
  end

  create_table "shipping_addresses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "name"
    t.string   "address_line1"
    t.string   "address_line2"
    t.string   "city"
    t.string   "state_province_region"
    t.string   "zip_or_postal_code"
    t.integer  "country_id"
    t.string   "phone"
    t.integer  "no_of_sets"
    t.integer  "transcript_application_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "autofill_address"
    t.index ["country_id"], name: "index_shipping_addresses_on_country_id", using: :btree
    t.index ["transcript_application_id"], name: "index_shipping_addresses_on_transcript_application_id", using: :btree
  end

  create_table "shipping_fees", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "shipping_charge"
    t.integer  "weight_category_id"
    t.integer  "country_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["country_id"], name: "index_shipping_fees_on_country_id", using: :btree
    t.index ["weight_category_id"], name: "index_shipping_fees_on_weight_category_id", using: :btree
  end

  create_table "states", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "name"
    t.string   "iso"
    t.integer  "country_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "state_id"
    t.index ["country_id"], name: "index_states_on_country_id", using: :btree
  end

  create_table "transcript_applications", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "user_id"
    t.integer  "location_id"
    t.string   "university_name"
    t.string   "college_name"
    t.string   "course_name"
    t.string   "register_number"
    t.date     "enrollment_year"
    t.date     "completion_year"
    t.string   "delivery_partner"
    t.string   "ndocs"
    t.integer  "quantity"
    t.boolean  "nri"
    t.boolean  "foriegnNational"
    t.boolean  "studiedAbroad"
    t.boolean  "consolidatedMemo"
    t.string   "shippingAddress_sets1"
    t.string   "shippingAddress_country1"
    t.string   "shippingAddress_sets2"
    t.string   "shippingAddress_country2"
    t.string   "degreecertificate"
    t.string   "universityNotes"
    t.string   "packetContents"
    t.string   "wesForm"
    t.string   "syllabusRequired"
    t.string   "campus"
    t.string   "selectOutreachOption"
    t.string   "remark"
    t.integer  "processingWeeks"
    t.string   "eta"
    t.integer  "service_days"
    t.decimal  "university_charge",        precision: 15, scale: 2
    t.integer  "discount_coupon_code"
    t.boolean  "coupon_applied",                                    default: false
    t.decimal  "service_charge",           precision: 15, scale: 2
    t.decimal  "service_tax",              precision: 15, scale: 2
    t.decimal  "shippingFee",              precision: 15, scale: 2
    t.decimal  "total",                    precision: 15, scale: 2
    t.string   "currency",                                          default: "INR"
    t.datetime "created_at",                                                        null: false
    t.datetime "updated_at",                                                        null: false
    t.string   "student_name"
    t.integer  "university_id"
    t.index ["location_id"], name: "index_transcript_applications_on_location_id", using: :btree
    t.index ["user_id"], name: "index_transcript_applications_on_user_id", using: :btree
  end

  create_table "universities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "name"
    t.string   "address"
    t.string   "contact"
    t.integer  "university_code"
    t.integer  "transcript_application_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "banner_image"
    t.string   "subdomain"
    t.index ["transcript_application_id"], name: "index_universities_on_transcript_application_id", using: :btree
  end

  create_table "university_details", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "university_code"
    t.integer  "university_id"
    t.string   "name"
    t.string   "serviceDays"
    t.string   "processingWeeks"
    t.text     "universityNotes",    limit: 65535
    t.text     "packetContents",     limit: 65535
    t.string   "type"
    t.string   "ddName"
    t.string   "officeAddress"
    t.decimal  "discount",                         precision: 10
    t.string   "numberOfYears"
    t.string   "CMMcharges"
    t.string   "penaltyFee"
    t.text     "shippingaddress",    limit: 65535
    t.string   "searchFee"
    t.string   "university_charge"
    t.boolean  "nri",                                             default: false
    t.boolean  "foreign_national",                                default: false
    t.boolean  "studied_abroad",                                  default: false
    t.boolean  "consolidated_memo",                               default: false
    t.boolean  "degree_certificate",                              default: false
    t.boolean  "wes_form",                                        default: false
    t.boolean  "syllabus_required",                               default: false
    t.integer  "weight"
    t.datetime "created_at",                                                      null: false
    t.datetime "updated_at",                                                      null: false
    t.integer  "service_charge"
    t.string   "fee_formula"
    t.string   "dynamic_update"
    t.index ["university_id"], name: "index_university_details_on_university_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "name"
    t.string   "mobile"
    t.string   "indiaId"
    t.string   "nameFirst"
    t.string   "nameLast"
    t.boolean  "sms_subscription",       default: false
    t.boolean  "email_subscription",     default: false
    t.integer  "order_id"
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,     null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["order_id"], name: "index_users_on_order_id", using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "weight_categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "weight_range_start"
    t.integer  "weight_range_end"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_foreign_key "cca_transactions", "ct_transactions"
  add_foreign_key "cca_transactions", "ct_transactions", column: "transaction_id"
  add_foreign_key "kv_entries", "payment_notifications"
  add_foreign_key "paypal_transactions", "ct_transactions"
end

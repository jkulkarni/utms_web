json.extract! payment_notification, :id, :params, :order_id, :status, :transaction_id, :create, :created_at, :updated_at
json.url payment_notification_url(payment_notification, format: :json)
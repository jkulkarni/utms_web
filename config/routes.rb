ValidSubdomains = ["sdmcet", "admin"]

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :payment_notifications


  devise_for :users
  #mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  match '/', to: 'transcript_applications#index', constraints: { subdomain: 'www' }, via: [:get, :post, :put, :patch, :delete]
  match '/', to: 'transcript_applications#new', constraints: lambda {|request| ValidSubdomains.include?(request.subdomains[0])}, via: [:get, :post, :put, :patch, :delete]

  root to: "transcript_applications#new"

  post '/paypal_ipn_listener', action: :listener, controller: 'paypal_ipn'

  controller :transcript_applications do
    get  'update_transcript_applications'
    post  'update_transcript_applications'
    post  'transcript_applications'
    post  'update_form'
    post  'boolean_form_fields_required'
    post  'new'
    get  'new'
    get  'about_us'
    get  'testimonials'
    get 'states_by_country'

  end

  controller :payments do
    get  'dataForm'
    get  'ccavRequestHandler'
    post  'ccavRequestHandler'
    get  'ccavResponseHandler'
    post  'ccavResponseHandler'
    get 'paypalRequestHandler'
    post 'paypalResponseHandler', :as => :paypal_response_handler
    get 'paymentRequestHandler'
  end

  controller :transactions do
    get  'express'
    get  'new_transaction'
    post  'create'
  end


  get  '/status' => 'orders#application_status', :as => :status
  post '/status' => 'orders#application_status2'
  controller :orders do
    get  'show', :as => :orders_show
    post  'show'
  end

  controller :home do
    get  'account_details'
    get  'temp_individual_application_details'
  end

  get '/transcript_applications/institute_names' => 'transcript_applications#institute_names', :as => :transcript_application_institute_names
  get '/transcript_applications/autofill' => 'transcript_applications#autofill', :as => :transcript_application_autofill
  resources :transcript_applications

  get '/order_items/delete_order' => 'order_items#delete_order', :as => :order_item_delete_order
  resources :order_items
  root to: "products#index"

end
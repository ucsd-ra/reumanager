Reuman::Application.routes.draw do
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  namespace :applicants do
    match "recommendations/:token" => "recommendations#edit", via: :get, as: :recommendations_edit
    post "recommendations/:id" => "recommendations#resend_request", as: :recommendations_request
    match "recommendations/:token" => "recommendations#update", via: :put, as: :recommendations_update

    get "recommenders" => "recommenders#edit"
    put "recommenders" => "recommenders#update"

    get "records" => "academic_records#edit"
    put "records" => "academic_records#update"
    delete "records" => "academic_records#destroy"
  end

  devise_for :applicants, :controllers => { :confirmations => "applicants/confirmations", :registrations => "applicants/registrations", :sessions => "applicants/sessions" }

  devise_scope :applicant do
    get "applicants/status" => "applicants/registrations#status", :as => :applicant_status
    get "applicants/submit" => "applicants/registrations#submit", :as => :submit_application
  end

  devise_for :users, :controllers => { :sessions => "users/sessions" }
  
  devise_scope :user do
    match "users/sign_out" => "devise/sessions#destroy"
  end

  match "closed" => "welcome#closed"
  match "thanks" => "welcome#thanks"

  root :to => "welcome#index"
end
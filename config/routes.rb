Reuman::Application.routes.draw do
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  namespace :applicants do
    get "recommenders" => "recommenders#edit"
    put "recommenders" => "recommenders#update"
    delete "recommenders" => "recommenders#destroy"

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

  root :to => "welcome#index"
end

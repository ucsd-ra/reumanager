Rails.application.routes.draw do

  get 'snippets/index'

  get 'settings/index'

  # resources :grant_settings
  resources :admin_accounts
  # resources :grant_snippets
  resources :settings
  resources :snippets
  resources :grants
  resources :charges


  # mount Rich::Engine => '/rich', :as => 'rich'
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  namespace :applicants do
    get "recommendations/:token" => "recommendations#edit", as: :recommendations_edit
    post "recommendations/:id" => "recommendations#resend_request", as: :recommendations_request
    put "recommendations/:token" => "recommendations#update", as: :recommendations_update

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
    get "users/sign_out" => "devise/sessions#destroy"
  end

  get "closed" => "welcome#closed"
  get "thanks" => "welcome#thanks"

  root :to => "grants#index"

  # root "grants#index"

end

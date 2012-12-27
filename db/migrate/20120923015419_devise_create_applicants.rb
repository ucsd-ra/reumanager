class DeviseCreateApplicants < ActiveRecord::Migration
  def change
    create_table(:applicants) do |t|
      
      # contact info
      t.string :first_name
      t.string :last_name
      t.string :phone
      
      # personal  info
      t.date :dob
      t.string :citizenship
      t.string :disability
      t.string :gender
      t.string :ethnicity
      t.string :race
      
      # academic info
      t.text :gpa_comment
      t.text :lab_skills
      t.text :cpu_skills
      t.text :statement
      
      t.datetime :submitted_at
      
      ## Database authenticatable
      t.string :email,              :null => false, :default => ""
      t.string :encrypted_password, :null => false, :default => ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, :default => 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      t.integer  :failed_attempts, :default => 0 # Only if lock strategy is :failed_attempts
      t.string   :unlock_token # Only if unlock strategy is :email or :both
      t.datetime :locked_at

      ## Token authenticatable
      t.string :authentication_token
      
      ## ActsAsStateMachine State
      t.string :aasm_state
      
      t.timestamps
    end

    add_index :applicants, :email,                :unique => true
    add_index :applicants, :reset_password_token, :unique => true
    add_index :applicants, :confirmation_token,   :unique => true
    add_index :applicants, :unlock_token,         :unique => true
    add_index :applicants, :authentication_token, :unique => true
  end
end

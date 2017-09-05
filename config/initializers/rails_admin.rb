# RailsAdmin config file. Generated on September 22, 2012 18:58
# See github.com/sferik/rails_admin for more informations
require Rails.root.join('lib', 'admin_accept')
require Rails.root.join('lib', 'admin_reject')

RailsAdmin.config do |config|
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  config.audit_with :history, Applicant
  config.audit_with :history, User

  # Set the admin name here (optional second array element will appear in a beautiful RailsAdmin red ©)
  config.main_app_name = ['Reuman', 'Admin']

  config.default_items_per_page = 50

  config.actions do
    # root actions
    dashboard                     # mandatory
    # collection actions
    index                         # mandatory
    new
    export
    history_index
    bulk_delete
    # member actions
    show
    edit
    delete
    history_show
    show_in_app
    accept do
      visible do
        ["Applicant", "Applied", "Submitted", "Complete", "MissedDeadline", "Withdrawn", "Rejected", "Accepted"].include?(bindings[:abstract_model].model.to_s)
      end
    end
    reject do
      visible do
        ["Applicant", "Applied", "Submitted", "Complete", "MissedDeadline", "Withdrawn", "Rejected", "Accepted"].include?(bindings[:abstract_model].model.to_s)
      end
    end
  end

  applicant_config = lambda {
        list do

      field :name do
        searchable :last_name
        sortable :last_name
        filterable false
      end

      field :first_name do
        searchable true
        filterable false
        visible false
      end

      field :last_name do
        searchable true
        filterable true
        visible false
      end

      field :academic_info do
        formatted_value do
          bindings[:object].academic_record(bindings[:object].record)
        end
      end

      field :current_status do
        searchable :state
        sortable :state
        filterable :state
        visible false
      end
      field :created_at do
        label "Started on"
        date_format :short
      end
    end

    show do
      field :personal_info do
        label "Personal Info"
        formatted_value do
          applicant = bindings[:object]
          bindings[:view].raw %{<b>Email</b> #{applicant.email}<br />
            <b>Phone</b> #{applicant.phone if applicant.phone}<br />
            <b>Address</b>  #{applicant.address}

          <h4>Statement</h4>
          #{Markdown.new applicant.statement if applicant.statement}}
        end
      end

      field :academic_info do
        formatted_value do
          applicant = bindings[:object]
          records = applicant.records
          awards = applicant.awards

          bindings[:view].render(:partial => 'applicant_academic_records',
                                 :locals => {:link => bindings[:view].link_to(applicant.records.last.transcript_file_name, applicant.transcript.url),
                                             :applicant => applicant,
                                             :records => records,
                                             :awards => awards,
                                             :view_bindings => bindings[:view]
                                            }
                                )
        end
      end

      field :recommendation_info do
        formatted_value do
          applicant = bindings[:object]
          recommendations = applicant.recommendations

          bindings[:view].render(:partial => 'applicant_recommendations', :locals => {:applicant => applicant, :recommendations => recommendations, :view_bindings => bindings[:view]})
        end
      end
    end

    edit do
      field :state, :enum do
        label "Current Status"
        enum do
          ['applied', 'completed_personal_info', 'completed_academic_info', 'completed_recommender_info', 'incomplete', 'submitted', 'complete', 'withdrawn', 'rejected', 'accepted']
        end
      end
      field :first_name
      field :last_name
      field :email
    end
  }

  config.model Applicant do
    weight 0
    instance_exec(&applicant_config)
  end

  config.model Applied do
    label_plural 'Applied'
    weight 1
    instance_exec(&applicant_config)
  end

  config.model Submitted do
    label_plural 'Submitted (Awaiting Recommendations)'
    weight 2
    instance_exec(&applicant_config)
  end

  config.model Complete do
    label_plural 'Complete (with Recommendations) / Awaiting Review'
    weight 3
    instance_exec(&applicant_config)
  end

  config.model Rejected do
    label_plural "Rejected"
    weight 6
    instance_exec(&applicant_config)
  end

  config.model Accepted do
    label_plural 'Accepted'
    weight 7
    instance_exec(&applicant_config)
  end


  config.model AcademicRecord do
    def custom_label_method
      "#{self.degree}, #{self.university}"
    end

    visible false
  end
  config.model Address do
    visible false
  end
  config.model Award do
    visible false
  end

  config.model Recommendation do
    visible false
    edit do
      field :known_applicant_for
      field :known_capacity
      field :overall_promise
      field :undergraduate_institution
      field :body
      field :recommender
    end
  end
  config.model Recommender do
    visible false
    edit do
      field :first_name
      field :last_name
      field :email
      field :phone
      field :url
      field :organization
      field :department
      field :title
    end
  end
  config.model Setting do
    edit do
      field :display_name
      field :name
      field :description
      field :value
    end
    list do
      field :display_name
      field :description
      field :value
    end
    show do
      field :name
      field :description
      field :value
    end
  end
  config.model Snippet do
    edit do
      field :display_name
      field :name
      field :description
      field :value, :rich_editor do
       config({
         :insert_many => true
       })
     end
    end
    list do
      field :display_name
      field :description
      field :value do
        formatted_value do
          bindings[:view].strip_tags value.truncate(255)
        end
      end
    end
  end

  config.model User do
    visible false
    #     configure :id, :integer
    #     configure :email, :string
    #     configure :password, :password         # Hidden
    #     configure :password_confirmation, :password         # Hidden
    #     configure :reset_password_token, :string         # Hidden
    #     configure :reset_password_sent_at, :datetime
    #     configure :remember_created_at, :datetime
    #     configure :sign_in_count, :integer
    #     configure :current_sign_in_at, :datetime
    #     configure :last_sign_in_at, :datetime
    #     configure :current_sign_in_ip, :string
    #     configure :last_sign_in_ip, :string
    #     configure :failed_attempts, :integer
    #     configure :unlock_token, :string
    #     configure :locked_at, :datetime
    #     configure :authentication_token, :string
    #     configure :created_at, :datetime
    #     configure :updated_at, :datetime   #   # Sections:
    #   list do; end
    #   export do; end
    #   show do; end
    #   edit do; end
    #   create do; end
    #   update do; end
  end
end

# RailsAdmin config file. Generated on September 22, 2012 18:58
# See github.com/sferik/rails_admin for more informations

RailsAdmin.config do |config| 
  config.current_user_method { current_user } # auto-generated

  config.audit_with :history, Applicant
  config.audit_with :history, User

  # Set the admin name here (optional second array element will appear in a beautiful RailsAdmin red ©)
  config.main_app_name = ['Reuman', 'Admin']

  config.default_items_per_page = 50

  config.navigation_static_label = "Applicant Status Groups"
  
  config.navigation_static_links = {
    'Applied' => 'http://localhost:3000/admin/applicant?utf8=%E2%9C%93&f%5Bcurrent_status%5D%5B80479%5D%5Bo%5D=like&f%5Bcurrent_status%5D%5B80479%5D%5Bv%5D=Applied&query=',
    'Completed Personal Info' => 'http://localhost:3000/admin/applicant?utf8=%E2%9C%93&f%5Bcurrent_status%5D%5B80479%5D%5Bo%5D=like&f%5Bcurrent_status%5D%5B80479%5D%5Bv%5D=Completed+Personal+Info&query=',
    'completed_academic_info' => 'http://localhost:3000/admin/applicant?utf8=%E2%9C%93&f%5Bcurrent_status%5D%5B80479%5D%5Bo%5D=like&f%5Bcurrent_status%5D%5B80479%5D%5Bv%5D=Applied&query=',
    'completed_recommender_info' => 'http://localhost:3000/admin/applicant?utf8=%E2%9C%93&f%5Bcurrent_status%5D%5B80479%5D%5Bo%5D=like&f%5Bcurrent_status%5D%5B80479%5D%5Bv%5D=Applied&query=',
    'submitted' => 'http://localhost:3000/admin/applicant?utf8=%E2%9C%93&f%5Bcurrent_status%5D%5B80479%5D%5Bo%5D=like&f%5Bcurrent_status%5D%5B80479%5D%5Bv%5D=Applied&query=',
    'completed' => 'http://localhost:3000/admin/applicant?utf8=%E2%9C%93&f%5Bcurrent_status%5D%5B80479%5D%5Bo%5D=like&f%5Bcurrent_status%5D%5B80479%5D%5Bv%5D=Applied&query=',
    'missed_deadline' => 'http://localhost:3000/admin/applicant?utf8=%E2%9C%93&f%5Bcurrent_status%5D%5B80479%5D%5Bo%5D=like&f%5Bcurrent_status%5D%5B80479%5D%5Bv%5D=Applied&query=',
    'withdrawn' => 'http://localhost:3000/admin/applicant?utf8=%E2%9C%93&f%5Bcurrent_status%5D%5B80479%5D%5Bo%5D=like&f%5Bcurrent_status%5D%5B80479%5D%5Bv%5D=Applied&query=',
    'rejected' => 'http://localhost:3000/admin/applicant?utf8=%E2%9C%93&f%5Bcurrent_status%5D%5B80479%5D%5Bo%5D=like&f%5Bcurrent_status%5D%5B80479%5D%5Bv%5D=Applied&query=',
    'accepted' => 'http://localhost:3000/admin/applicant?utf8=%E2%9C%93&f%5Bcurrent_status%5D%5B80479%5D%5Bo%5D=like&f%5Bcurrent_status%5D%5B80479%5D%5Bv%5D=Applied&query='
  }

  config.model Applicant do
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
          #{Markdown.render applicant.statement if applicant.statement}}
        end
      end

      field :academic_info do
        formatted_value do
          applicant = bindings[:object]
          records = applicant.records
          awards = applicant.awards
          
          html = bindings[:view].render(:partial => 'applicant_personal_info', :locals => {:link => bindings[:view].link_to(applicant.records.last.transcript_file_name, applicant.transcript.url), :applicant => applicant, :records => records, :awards => awards})
          bindings[:view].raw html
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
      field :recommendations
    end
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
  end
  config.model Recommender do
    visible false
  end
  config.model Setting do
    edit do
      field :name do
        formatted_value do
          bindings[:object].name.gsub('_',' ').titleize
        end
      end
      field :description, :text do
        ckeditor false
      end
      
      field :value
    end
    list do
      field :name do
        formatted_value do
          bindings[:object].name.gsub('_',' ').titleize
        end
      end
      field :description
      field :value
    end
    show do
      field :name do
        formatted_value do
          bindings[:object].name.gsub('_',' ').titleize
        end
      end
    end
  end
  config.model Snippet do
    edit do
      field :name do
        formatted_value do
          bindings[:object].name.gsub('_',' ').titleize
        end
      end
      field :description
      field :value, :rich_editor
    end
    list do
      field :name do
        formatted_value do
          bindings[:object].name.gsub('_',' ').titleize
        end
      end
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

  config.model Rich::RichFile do
    visible false
  end
end

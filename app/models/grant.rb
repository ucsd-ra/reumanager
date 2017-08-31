class Grant < ActiveRecord::Base
	has_one :admin_account
	has_one :grant_setting
	has_one :grant_snippet

	validates :subdomain, exclusion: { in: %w(www admin), message: "%{value} is reserved"}
	after_create :create_tenant
	after_destroy :destroy_tenant

	def create_tenant
		Apartment::Tenant.create(subdomain)
		Apartment::Tenant.switch!(subdomain)
		Setting.load_from_yaml
		Apartment::Tenant.switch!
	end

	def destroy_tenant
		Apartment::Tenant.drop(subdomain)
	end
	

end

module RescuedApartmentMiddleware
  def call(*args)
    begin
      super
   rescue Apartment::TenantNotFound
    Rails.logger.error "ERROR: Apartment Tenant not found: #{Apartment::Tenant.current.inspect}"
    return [301, {'Location' => 'http://lvh.me:3000'}, ['redirect']]
    end
  end
end
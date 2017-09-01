class ChargesController < ApplicationController
	before_action :amount_to_be_charged

def new
end

def create
 

  customer = Stripe::Customer.create(
    :email => 'amy.dyson@mac.com',
    :source  => params[:stripeToken]
  )

  charge = Stripe::Charge.create(

    :customer    => customer.id,
    :amount      => @amount,
    :description => 'Rails Stripe customer',
    :currency    => 'usd'
  )

  redirect_to new_grant_setting_url(subdomain: @subdomain)


rescue Stripe::CardError => e
  flash[:error] = e.message
  redirect_to new_charge_path
end

private

	def amount_to_be_charged
		@amount = 2500
	end

end

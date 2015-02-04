Rails.configuration.stripe = {
  :publishable_key => ENV['STRIPE_PUBLISHABLE_KEY'],
  :secret_key      => ENV['STRIPE_SECRET_KEY']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
StripeEvent.configure do |events|

  
  events.subscribe 'invoice.payment_failed' do |event|
    customer_id = event.data.object["customer"]
    
    # Revoke access immediately
    user = User.find_by(customer_id: customer_id)
    user.extra_access = false
    user.save
    
    # Send email notifications to user + Susie
    UserMailer.invoice_payment_failed(user.email, user.name).deliver
  end
  
  events.subscribe 'customer.subscription.deleted' do |event|
    customer_id = event.data.object["customer"]
    
    # Revoke access immediately
    user = User.find_by(customer_id: customer_id)
    
    # Revoke access immediately
    user.extra_access = false
    user.save
    
    # Send email notification to user
    UserMailer.access_ended(user.email, user.name).deliver
  end
end
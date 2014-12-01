class Subscription < ActiveRecord::Base
  belongs_to :plan
  belongs_to :user
  validates_presence_of :plan_id
  validates_presence_of :email
  attr_accessor :stripe_card_token

  def save_with_payment
    if valid?
      customer = Stripe::Customer.create(
        :card => stripe_card_token,
        :plan => plan_id, 
        :email => email,
        :description => "#{name} - ID: #{user_id}"
      )
      self.stripe_customer_token = customer.id
      self.stripe_card_token = stripe_card_token
      save!
    end
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
    false
  end
end
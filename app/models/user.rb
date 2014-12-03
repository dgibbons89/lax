class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :school, :position, :name




def save_with_payment
    if valid?
      customer = Stripe::Customer.create(
        :card => stripe_card_token,
        :plan => "Monthlyplan", 
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
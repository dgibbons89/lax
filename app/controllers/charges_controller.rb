class ChargesController < ApplicationController
  before_action :authenticate_user!

  def new
  end

  def create
    # Amount in cents
    @amount = amount

    customer = Stripe::Customer.create(
      :email => current_user.email,
      :card  => stripe_card_token
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      
      :currency    => 'usd'
    )

    current_user.update_attribute(:extra_access, true)
    redirect_to lessons_path

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  end
end
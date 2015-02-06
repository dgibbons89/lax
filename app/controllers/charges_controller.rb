class ChargesController < ApplicationController
  before_action :authenticate_user!

  def new
  end

  def create
    # Amount in cents
    @amount = 2000
    token = params[:stripeToken]

    customer = Stripe::Customer.create(
      
      :email => current_user.email,
      :description => current_user.name,
      :card => token,
      :plan => "monthly",
    )



    current_user.update_attribute(:extra_access, true)
    UserMailer.invoice_payment_succeeded(current_user.email, current_user.name).deliver
    redirect_to thanks_path
    

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  end




end
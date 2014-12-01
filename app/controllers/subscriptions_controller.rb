class SubscriptionsController < ApplicationController
  

  def new
    plan = Plan.find(params[:plan_id])
    @subscription = plan.subscriptions.build
    @useremail = current_user.email
    @username = current_user.name
    @userid = current_user.id
  end

  def create
    @subscription = Subscription.new(subscription_params)
    if @subscription.save_with_payment
      current_user.add_role(:vip_player)
      redirect_to @subscription, :notice => "Thank you for subscribing!"
    else
      render :new
    end
  end

  def show
    @subscription = Subscription.find(params[:id])
  end

  private
    def subscription_params
      params.require(:subscription).permit(:name, :plan_id, :email, :stripe_card_token, :user_id)
    end
end
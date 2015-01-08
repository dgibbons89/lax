class PurchaseMailer < ActionMailer::Base
	
	default from: "TelosLax <dg@TelosLax.com>"

	 # Invoice payment succeeded
  def invoice_payment_succeeded(recipient_email, recipient_name, amount)
    @recipient_name = recipient_name
    @amount = amount
    
    # Email user
    email_with_name = "#{recipient_name} <#{recipient_email}>"
    mail to: email_with_name, subject: "TelosLax payment notification"
  end
  
  # Invoice payment failed
  def invoice_payment_failed(recipient_email, recipient_name)
    @recipient_name = recipient_name
    
    # Email user
    email_with_name = "#{recipient_name} <#{recipient_email}>"
    mail to: email_with_name, subject: "TelosLax payment failed"
    
    # Email Susie
    mail to: "Dean <dg@TelosLax.com>", subject: "Automatic unsubscribe: #{recipient_email}"
  end
  
  # Access ended
  def access_ended(recipient_email, recipient_name)
    @recipient_name = recipient_name
    email_with_name = "#{recipient_name} <#{recipient_email}>"
    mail to: email_with_name, subject: "Your TelosLax access has ended"
  end
  
  # Subscription cancelled
  def subscription_cancelled(recipient_email, recipient_name)
    @recipient_name = recipient_name
    email_with_name = "#{recipient_name} <#{recipient_email}>"
    mail to: email_with_name, subject: "TelosLax subscription cancelled"
  end
  
  



  # New paid subscription is created
  def new_subscription(user_name, email, plan)
    @user_name = user_name
    @email = email
    @plan = plan

    mail to: "Dean <dg@TelosLax.com>", subject: "#{plan.capitalize} User: #{email}"
  end

  # Free user converts to paid subscription
  def convert_to_paid(user_name, email, plan)
    @user_name = user_name
    @email = email
    @plan = plan

    mail to: "Dean <dg@TelosLax.com>", subject: "Convert to #{plan}: #{email}"
  end

  # User manually changes subscription plan
  def edit_subscription(user_name, email, plan)
    @user_name = user_name
    @email = email
    @plan = plan

  mail to: "Dean <dg@TelosLax.com>", subject: "Subscription changed to #{plan}"
  end

  # User manually cancelled subscription
  def unsubscribe(user_name, email, plan)
    @user_name = user_name
    @plan = plan
    @email = email

    mail to: "Dean <dg@TelosLax.com>", subject: "#{user_name} unsubscribed from the #{plan} plan"
  end
end
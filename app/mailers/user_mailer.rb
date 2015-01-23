class UserMailer < ActionMailer::Base
  layout 'user_mailer'
  default from: "Telos Lax <dg@teloslax.com>"


  def new_user user
    @user = user
    mail to: user.email, subject: "Thanks for signing up!"
  end
  
  # Invoice payment succeeded
  def invoice_payment_succeeded(recipient_email, recipient_name, amount)
    @recipient_name = recipient_name
    @amount = amount
    
    # Email user
    email_with_name = "#{recipient_name} <#{recipient_email}>"
    mail to: email_with_name, subject: "Telos Lax payment notification"
  end
  
  # Invoice payment failed
  def invoice_payment_failed(recipient_email, recipient_name)
    @recipient_name = recipient_name
    
    # Email user
    email_with_name = "#{recipient_name} <#{recipient_email}>"
    mail to: email_with_name, subject: "Telos Lax payment failed"
    
    # Email Susie
    mail to: "Dean Gibbons <dg@teloslax.com>", subject: "Automatic unsubscribe: #{recipient_email}"
  end
  

  
  # Subscription cancelled
  def subscription_cancelled(recipient_email, recipient_name)
    @recipient_name = recipient_name
    email_with_name = "#{recipient_name} <#{recipient_email}>"
    mail to: email_with_name, subject: "Telos Lax subscription cancelled"
  end
  
  




  # SUSIE NOTIFICATIONS
  # New free membership is created


  # New paid subscription is created
  def new_subscription(user_name, email, plan)
    @user_name = user_name
    @email = email
    @plan = plan

    mail to: "Dean Gibbons <dg@teloslax.com>", subject: "#{plan.capitalize} User: #{email}"
  end

  # Free user converts to paid subscription
  def convert_to_paid(user_name, email, plan)
    @user_name = user_name
    @email = email
    @plan = plan

    mail to: "Dean Gibbons <dg@teloslax.com>", subject: "Convert to #{plan}: #{email}"
  end

  # User manually changes subscription plan
  def edit_subscription(user_name, email, plan)
    @user_name = user_name
    @email = email
    @plan = plan

   mail to: "Dean Gibbons <dg@teloslax.com>", subject: "Subscription changed to #{plan}"
  end

  # User manually cancelled subscription
  def unsubscribe(user_name, email, plan)
    @user_name = user_name
    @plan = plan
    @email = email

    mail to: "Dean Gibbons <dg@teloslax.com>", subject: "#{user_name} unsubscribed from the #{plan} plan"
  end
end
class PagesController < ApplicationController
  def home
  end

  def faq
  end
  def terms
  end
  def privacy
  end
  def academic
    
      redirect_to new_charge_path unless current_user.extra_access == true 
  end
  def film
    
      redirect_to new_charge_path unless current_user.extra_access == true 
  end

  def thanks
  end
    
  end


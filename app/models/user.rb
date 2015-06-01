class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  after_create :send_welcome_email
  after_destroy :delete_stripe 

  def send_welcome_email
    UserMailer.new_user(name, email).deliver
  end

  def delete_stripe
    UserMailer.delete_user(name, email).deliver
  end

   



  validates :name, presence: true
  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy

end
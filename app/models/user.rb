class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

    validates_presence_of :school,  :birthday, :position, :name

   has_one :subscription

         def create_a_customer
         	token = self.stripe_card_token
         	
         	customer = Stripe::Customer.create(
  				:card => token,
  				:plan => 1,
  				:email => self.email
			)       	
			#Need to note that User cc has gone through
         end

         

end
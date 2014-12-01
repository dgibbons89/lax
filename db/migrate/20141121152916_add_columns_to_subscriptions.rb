class AddColumnsToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :name, :string
    add_column :subscriptions, :plan_id, :integer
    add_column :subscriptions, :email, :string
    add_column :subscriptions, :stripe_customer_token, :string
    add_column :subscriptions, :user_id, :integer
    add_column :subscriptions, :stripe_card_token, :string
  end
end

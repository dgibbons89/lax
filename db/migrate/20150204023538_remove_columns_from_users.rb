class RemoveColumnsFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :age, :string
    remove_column :users, :birthday, :string
    remove_column :users, :stripe_card_token, :string
    remove_column :users, :last_4_digits, :string
    remove_column :users, :plan, :string
    remove_column :users, :amount, :string
  end
end

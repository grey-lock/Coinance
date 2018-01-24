class CreateWallets < ActiveRecord::Migration[5.1]
  def change
    create_table :wallets do |t|
      t.string :name
      t.float :coin_amount, default: 0.0
      t.float :user_deposit, default: 0.0
      t.float :net_value, default: 0.0
      t.belongs_to :user
      t.belongs_to :coin

      t.timestamps
    end
  end
end

class CreateWallets < ActiveRecord::Migration[5.1]
  def change
    create_table :wallets do |t|
      t.string :name
      t.decimal :coin_amount, default: 0.0000, precision: 12, scale: 6
      t.decimal :user_deposit, default: 0.0000, precision: 12, scale: 6
      t.decimal :net_value, default: 0.0000, precision: 12, scale: 6
      t.belongs_to :user
      t.belongs_to :coin

      t.timestamps
    end
  end
end

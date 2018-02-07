class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.float :amount, default: 0.0000, precision: 12, scale: 6
      t.float :quantity, default: 0.0000, precision: 12, scale: 6
      t.float :price_per_coin, default: 0.0000, precision: 12, scale: 6
      t.float :fee, default: 0.0000, precision: 12, scale: 6
      t.belongs_to :user
      t.belongs_to :coin
      
      t.timestamps
    end
  end
end

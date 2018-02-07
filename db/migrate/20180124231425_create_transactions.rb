class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.decimal :amount, default: 0.0000, precision: 12, scale: 6
      t.decimal :quantity, default: 0.0000, precision: 12, scale: 6
      t.decimal :price_per_coin, default: 0.0000, precision: 12, scale: 6
      t.decimal :fee, default: 0.0000, precision: 12, scale: 6
      t.belongs_to :user
      t.belongs_to :coin
      
      t.timestamps
    end
  end
end

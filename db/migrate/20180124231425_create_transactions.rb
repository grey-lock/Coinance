class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.float :amount, default: 0.0
      t.float :quantity, default: 0.0
      t.float :price_per_coin, default: 0.0
      t.float :fee, default: 0.0
      t.belongs_to :user
      t.belongs_to :coin
      # t.belongs_to :wallet
      
      t.timestamps
    end
  end
end

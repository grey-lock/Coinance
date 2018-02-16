class AddColumnToWallets < ActiveRecord::Migration[5.1]
  def change
    add_column :wallets, :notes, :string
  end
end

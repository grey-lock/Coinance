class CreateCoins < ActiveRecord::Migration[5.1]
  def change
    create_table :coins do |t|
      t.string :name
      t.float :last_known_value, default: 0.0
      t.string :symbol

      t.timestamps
    end
  end
end

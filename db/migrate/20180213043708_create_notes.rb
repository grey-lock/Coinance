class CreateNotes < ActiveRecord::Migration[5.1]
  def change
    create_table :notes do |t|
      t.text :comment
      t.belongs_to :transaction
      t.timestamps
    end
  end
end

class CreateShoppingRecords < ActiveRecord::Migration[7.1]
  def change
    create_table :shopping_records do |t|

      t.references :user,                null: false, foreign_key: true
      t.references :item,                null: false, foreign_key: true

      t.timestamps
    end
  end
end

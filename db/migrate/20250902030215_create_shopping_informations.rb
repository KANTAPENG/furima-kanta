class CreateShoppingInformations < ActiveRecord::Migration[7.1]
  def change
    create_table :shopping_informations do |t|

      t.string :postal_code,            null: false
      t.integer :prefecture_id,         null: false
      t.string :municipality,           null: false
      t.string :street_address,         null: false
      t.string :building_name,          null: false
      t.string :phone_number,           null: false
      t.references :shopping_record,    null: false, foreign_key: true

      t.timestamps
    end
  end
end

class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string  :item_name,              null: false
      t.text    :item_information,       null: false
      t.integer :item_type_id,           null: false
      t.integer :item_condition_id,      null: false
      t.integer :shipping_cost_id,       null: false
      t.integer :prefecture_id,          null: false
      t.integer :days_to_ship_id,        null: false
      t.integer :price,                  null: false
      t.references :user,                 null: false, foreign_key: true

      t.timestamps
    end
  end
end
 
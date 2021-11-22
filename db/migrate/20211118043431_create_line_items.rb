class CreateLineItems < ActiveRecord::Migration[5.2]
  def change
    create_table :line_items do |t|
      t.references :order, index: true, foreign_key: true
      t.references :product, index: true, foreign_key: true
      t.integer :quantity
      t.integer :item_price
      t.integer :total_price
    end
  end
end

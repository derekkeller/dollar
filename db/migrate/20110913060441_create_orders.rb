class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.integer :number
      t.boolean :shipped
      t.date :date_ordered
      t.integer :revenue
      t.integer :category_id

      t.timestamps
    end
  end

  def self.down
    drop_table :orders
  end
end

class CreateOrders < ActiveRecord::Migration[7.2]
  def change
    create_table :orders do |t|
      t.integer :customer_id
      t.datetime :order_date
      t.string :status

      t.timestamps
    end
  end
end

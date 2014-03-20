class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.text :metadata
      t.datetime :ordered_at

      t.timestamps
    end
  end
end

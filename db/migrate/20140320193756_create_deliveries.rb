class CreateDeliveries < ActiveRecord::Migration
  def change
    create_table :deliveries do |t|
      t.string :name
      t.string :email
      t.text :address
      t.string :url

      t.timestamps
    end
  end
end

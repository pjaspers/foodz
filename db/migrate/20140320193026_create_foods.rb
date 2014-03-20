class CreateFoods < ActiveRecord::Migration
  def change
    create_table :food do |t|
      t.references :delivery
      t.string :name
      t.integer :price

      t.timestamps
    end
  end
end

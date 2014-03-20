class CreateLines < ActiveRecord::Migration
  def change
    create_table :lines do |t|
      t.references :food
      t.references :order

      t.timestamps
    end
  end
end

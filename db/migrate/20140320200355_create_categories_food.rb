class CreateCategoriesFood < ActiveRecord::Migration
  def up
    create_table :categories_food do |t|
      t.references :category
      t.references :food
    end
    add_index :categories_food, [:food_id, :category_id]
    add_index :categories_food, :food_id
  end

  def down
    drop_table :categories_foods
  end
end

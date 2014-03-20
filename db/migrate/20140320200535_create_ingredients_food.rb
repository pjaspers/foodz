class CreateIngredientsFood < ActiveRecord::Migration
  def change
    create_table :food_ingredients do |t|
      t.references :ingredient
      t.references :food
    end
    add_index :food_ingredients, [:food_id, :ingredient_id]
    add_index :food_ingredients, :food_id
  end

  def down
    drop_table :food_ingredients
  end
end

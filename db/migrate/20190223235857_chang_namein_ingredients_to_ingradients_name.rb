class ChangNameinIngredientsToIngradientsName < ActiveRecord::Migration[5.2]
  def change
    rename_column :ingredients, :name, :ingredients_name
  end
end

class CreateCategories < ActiveRecord::Migration[7.2]
  def change
    create_table :categories do |t|
      t.string :category_name, null: false
      t.string :description
      t.references :users, null: false, foreign_key: true

      t.timestamps
    end
  end
end

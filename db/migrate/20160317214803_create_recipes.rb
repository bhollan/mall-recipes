class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :name
      t.integer :user_id
      t.integer :cook_time_in_minutes
      t.integer :prep_time_in_minutes
      t.text :directions
    end
  end
end

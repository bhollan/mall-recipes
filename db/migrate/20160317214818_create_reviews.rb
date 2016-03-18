class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :user_id
      t.integer :recipe_id
      t.integer :stars
      t.text :text
    end
  end
end

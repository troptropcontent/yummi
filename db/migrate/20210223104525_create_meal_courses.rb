class CreateMealCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :meal_courses do |t|
      t.references :meal, null: false, foreign_key: true
      t.references :course, null: false, foreign_key: true

      t.timestamps
    end
  end
end

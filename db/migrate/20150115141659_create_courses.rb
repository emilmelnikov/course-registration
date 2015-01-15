class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :title
      t.integer :credits
      t.integer :max_attendees

      t.timestamps null: false
    end
  end
end

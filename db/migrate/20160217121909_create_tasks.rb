class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name, null:false
      t.date :startdate,null:false
      t.date :enddate,null:false
      t.string :status,null:false
      t.string :description,null:false
      t.decimal :time_spent,:precision =>5,:scale=>2
      t.integer :project_id,null:false
      t.integer :user_id
      t.date :entry_date,null:false

      t.timestamps null: false
    end
  end
end

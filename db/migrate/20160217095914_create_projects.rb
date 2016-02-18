class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :pname, null: false
      t.date :startdate, null: false
      t.date :enddate, null: false
      t.date :duedate, null: false
      t.string :status, null: false
      t.string :description

      t.timestamps null: false
    end
  end
end

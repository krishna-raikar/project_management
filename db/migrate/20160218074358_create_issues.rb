class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.string :title , null: false
      t.string :description,null: false
      t.string :issue_category
      t.string :priority,null: false
      t.string :severity,null: false
      t.string :status,null: false
      t.date :entry_date,null: false
      t.integer :project_id,null: false
      t.integer :creator_id
      t.integer :assignee_id
      
      t.timestamps null: false
    end
  end
end

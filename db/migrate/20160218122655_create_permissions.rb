class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.integer :role_id,null: false
      t.string :modelname, null:false
      t.jsonb :per_list, default: '{}'

      t.timestamps null: false
    end
  end
end

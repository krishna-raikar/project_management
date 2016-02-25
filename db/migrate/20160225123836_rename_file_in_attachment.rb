class RenameFileInAttachment < ActiveRecord::Migration
  def change
  	rename_column :attachments,:file_data,:file
  end
end

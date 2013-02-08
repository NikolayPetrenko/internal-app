class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.references :user
      t.string :attachment

      t.timestamps
    end
    add_index :attachments, :user_id
  end
end

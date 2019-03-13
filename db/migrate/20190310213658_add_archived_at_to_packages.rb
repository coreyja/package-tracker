class AddArchivedAtToPackages < ActiveRecord::Migration[5.2]
  def change
    change_table :packages do |t|
      t.column :archived_at, :datetime, null: true
    end
  end
end

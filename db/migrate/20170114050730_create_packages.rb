class CreatePackages < ActiveRecord::Migration[5.0]
  def change
    create_table :packages do |t|
      t.string :name, null: false
      t.string :tracking_number, null: false
      t.string :carrier, null: false
      t.references :user, index: true, foreign_key: true, null: false

      t.timestamps
    end
  end
end

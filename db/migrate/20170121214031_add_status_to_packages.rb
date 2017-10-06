# frozen_string_literal: true

class AddStatusToPackages < ActiveRecord::Migration[5.0]
  def up
    add_column :packages, :status, :text, null: true
    add_column :packages, :estimated_delivery_date, :date, null: true

    execute "UPDATE packages SET status = 'unknown';"

    change_column_null :packages, :status, false
  end

  def down
    remove_column :packages, :status
    remove_column :packages, :estimated_delivery_date
  end
end

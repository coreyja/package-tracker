class RenameCarrierToCarrierCode < ActiveRecord::Migration[5.2]
  def change
    rename_column :packages, :carrier, :carrier_code
  end
end

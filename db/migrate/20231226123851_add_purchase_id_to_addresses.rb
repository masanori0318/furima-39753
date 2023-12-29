class AddPurchaseIdToAddresses < ActiveRecord::Migration[7.0]
  def change
    add_column :addresses, :purchase_id, :integer
  end
end

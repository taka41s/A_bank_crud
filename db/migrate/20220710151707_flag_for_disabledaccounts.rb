class FlagForDisabledaccounts < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :disabled_account, :boolean
    add_column :users, :admin, :boolean
  end
end

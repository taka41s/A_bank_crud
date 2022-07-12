class AlterColumnToInteger < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :current_balance, :BIGINT
    change_column :users, :wallet_balance, :BIGINT
  end
end

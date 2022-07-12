class AlterColumnToBigint < ActiveRecord::Migration[6.1]
  def change
    change_column :transactions, :amount, :BIGINT
    change_column :deposits, :amount, :BIGINT
    change_column :withdraws, :amount, :BIGINT
  end
end

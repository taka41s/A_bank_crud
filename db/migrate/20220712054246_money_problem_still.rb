class MoneyProblemStill < ActiveRecord::Migration[6.1]
  def change
    def change
      change_column :users, :current_balance, :decimal, :precision => 2, :scale => 2
      change_column :users, :wallet_balance, :decimal, :precision => 2, :scale => 2
    end
  end
end

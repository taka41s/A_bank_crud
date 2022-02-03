class Forusers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.float :current_balance, default: 0.0, null: false
      t.float :wallet_balance, default: 0.0, null: false

      t.timestamps
    end
  end
end
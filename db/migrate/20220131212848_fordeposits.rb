class Fordeposits < ActiveRecord::Migration[6.1]
  def change
    create_table :deposits do |t|
      t.string :bank_account
      t.float :amount
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
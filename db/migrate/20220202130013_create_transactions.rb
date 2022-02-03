class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.float :amount, default: 0.0, null: false
      t.string :from_user
      t.string :to_user
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

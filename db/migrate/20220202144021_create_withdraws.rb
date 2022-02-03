class CreateWithdraws < ActiveRecord::Migration[6.1]
  def change
    create_table :withdraws do |t|
      t.float :amount, default: 0.0, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

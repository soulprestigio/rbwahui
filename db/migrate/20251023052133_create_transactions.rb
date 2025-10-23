class CreateTransactions < ActiveRecord::Migration[7.2]
  def change
    create_table :transactions do |t|
      t.references :wallet, null: false, foreign_key: true
      t.decimal :amount, precision: 10, scale: 2, null: false
      t.string :transaction_type, null: false
      t.string :status, null: false
      t.string :payment_gateway_transaction_id

      t.timestamps

      t.index :transaction_type
      t.index :status
    end
  end
end

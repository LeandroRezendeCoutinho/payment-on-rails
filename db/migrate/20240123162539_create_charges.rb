class CreateCharges < ActiveRecord::Migration[7.1]
  def change
    create_table :charges do |t|
      t.monetize :amount
      t.boolean :capture
      t.string :status
      t.string :order_id
      t.string :payment_type
      t.string :source_type

      t.timestamps
    end
  end
end

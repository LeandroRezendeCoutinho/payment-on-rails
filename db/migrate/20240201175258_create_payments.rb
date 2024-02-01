class CreatePayments < ActiveRecord::Migration[7.1] # rubocop:disable Style/Documentation
  def change
    create_table :payments do |t|
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

class AddFkToPayment < ActiveRecord::Migration[7.1]
  def change
    add_reference :payments, :client
    add_reference :payments, :integration
  end
end

class CreateClients < ActiveRecord::Migration[7.1]
  def change
    create_table :clients do |t|
      t.string :client_id
      t.string :public_key
      t.string :private_key

      t.timestamps
    end
  end
end

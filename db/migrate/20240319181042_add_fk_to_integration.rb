class AddFkToIntegration < ActiveRecord::Migration[7.1]
  def change
    add_reference :integrations, :client
  end
end

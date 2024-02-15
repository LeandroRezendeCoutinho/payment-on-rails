class CreateIntegrations < ActiveRecord::Migration[7.1]
  def change
    create_table :integrations do |t|
      t.string :name
      t.json :config

      t.timestamps
    end
  end
end

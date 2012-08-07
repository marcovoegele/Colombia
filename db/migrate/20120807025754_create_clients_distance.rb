class CreateClientsDistance < ActiveRecord::Migration
  def change
    create_table :clients_distances, :id => false do |t|
      t.integer 'client_1_id', :null => false
      t.integer 'client_2_id', :null => false

    end

    add_index :clients_distances, [:client_1_id, :client_2_id], :unique => true, :name => 'clients_distance_1_2'
  end
end

class CreateDistanceForAndAddDistanceAndTimeColumns < ActiveRecord::Migration
  def change
    create_table :distance_for_clients, :primary_key => :client_id
    add_column   :clients_distances, :distance, :float
    add_column   :clients_distances, :time, :float
  end
end

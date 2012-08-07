class Client < ActiveRecord::Base
  has_many :clients_distance, :foreign_key => :client_1_id
  has_many :clients, :through => :clients_distance, :source => :client_1

  has_many :orders, :foreign_key => 'Client ID'

  self.primary_key = "Client ID"
end

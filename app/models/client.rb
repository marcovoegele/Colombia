class Client < ActiveRecord::Base
  has_many :bogota

  self.table_name = "Clients"
  self.primary_key = "Client ID"
end

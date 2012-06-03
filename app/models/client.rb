class Client < ActiveRecord::Base
  has_many :bogotas, :foreign_key => 'Client ID'

  self.table_name = "Clients"
  self.primary_key = "Client ID"
end

class Order < ActiveRecord::Base
  self.table_name = "Bogota"

  belongs_to :client, :foreign_key => "Client ID"
end

class Bogota < ActiveRecord::Base
  has_one :client

  self.table_name = "Bogota"
end

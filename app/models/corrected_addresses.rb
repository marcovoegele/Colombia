class CorrectedAddress < ActiveRecord::Base
  has_many :clients_distance, :foreign_key => :client_1_id
  has_many :corrected_addresses, :through => :clients_distance, :source => :client_1

  self.primary_key = "ClientID"
end

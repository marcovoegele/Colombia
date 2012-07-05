class CorrectedAddresses < ActiveRecord::Base
  self.primary_key = "ClientID"
  self.table_name = "corrected_addresses"
end

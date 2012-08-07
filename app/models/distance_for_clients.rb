class DistanceForClient < ActiveRecord::Base
  self.primary_key = 'client_id'

  belongs_to :corrected_address, :primary_key => 'ClientID', :foreign_key => :client_id
end

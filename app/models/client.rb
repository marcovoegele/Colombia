class Client < ActiveRecord::Base
  has_many :orders, :foreign_key => 'Client ID'

  self.primary_key = "Client ID"
end

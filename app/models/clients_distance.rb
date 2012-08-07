class ClientsDistance < ActiveRecord::Base
  belongs_to :client_1, :class_name => :CorrectedAddress
  belongs_to :client_2, :class_name => :CorrectedAddress
end

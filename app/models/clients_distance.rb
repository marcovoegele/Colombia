class ClientsDistance < ActiveRecord::Base
  belongs_to :client_1, :class_name => :Client
  belongs_to :client_2, :class_name => :Client
end

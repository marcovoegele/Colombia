#!/usr/bin/env ruby

require 'csv'

CSV.foreach("../Marco/BOGOTA.csv", :headers => true, :col_sep => '|') do |csv_obj|
  puts csv_obj.to_hash.keys.inspect
end

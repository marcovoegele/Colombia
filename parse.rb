#!/usr/bin/env ruby

require 'csv'
require 'net/http'
require 'json'
require 'cgi'

def email_filename
  "#{ENV['HOME']}/.email_address"
end

def _email
  if File.exists?(email_filename)
    email = File.readlines(email_filename).first.strip
    { :email => email }
  else
    puts "Make sure you create #{email_filename} with your email in it, otherwise you won't be able to make too many requests to open street map"
    { }
  end
end

def email
  @email ||= _email
end

def find address
  params = email.merge :q => address, :format => "json"# , :countrycodes => "CO"
  query_params = params.map {|k,v| CGI.escape(k.to_s)+'='+CGI.escape(v.to_s) }.join("&")

  puts query_params

  response = Net::HTTP.start('nominatim.openstreetmap.org', 80) do |http|
    http.get("/search?#{query_params}")
  end

  JSON.parse(response.body)
end

rows = CSV.open("../Marco/BOGOTA.csv", :headers => true, :return_headers => true, :col_sep => '|')
clients = CSV.open("../Marco/John4.csv", :headers => true, :col_sep => ',')

output_columns = rows.first.to_hash.keys << "Address"

client_id_to_client_address = clients.inject({ }) do |hash, client|
  hash[client['Client ID']] = client
  hash
end

rows_count = 0
missing_client_ids = []
CSV.open("../Marco/output.csv", "wb", :col_sep => '|') do |csv|
  csv << output_columns
  rows.each do |row|
    client_id = row['Cliente']
    client = client_id_to_client_address[client_id]
    address = "N/A"
    if client
      address = client['Address']
    else
      puts "Cannot find client with id #{client_id}" unless missing_client_ids.include?(client_id)
      missing_client_ids << client_id
    end
    output_row = row.to_hash.merge({ 'Address' => address})
    csv << output_columns.map{ |_| output_row[_] }
    rows_count += 1
    if rows_count % 1000 == 0
      puts "Inserted #{rows_count} rows"
    end
  end
end

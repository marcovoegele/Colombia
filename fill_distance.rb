#!/usr/bin/env ruby

$:.unshift File.dirname(__FILE__)

require 'uri'
require 'colombia'
require 'highline/import'
require 'net/http'

def join_lat_long *clients
  clients.map { |_| "#{_.Latitude},#{_.Longtitude}"}.join "|"
end

def url
  "maps.googleapis.com"
end

def path
  "/maps/api/distancematrix/json"
end

def get_distances origin, clients
  params = {
    :origins => join_lat_long(origin),
    :destinations => join_lat_long(*clients),
    :mode => :driving,
    :units => :imperial,
    :sensor => false
  }
  query_params = params.map {|k,v| "#{k.to_s}=#{v.to_s.gsub(' ', '+')}" }.join("&")
  request_path = URI.escape "#{path}?#{query_params}"
  puts "Using this path:\n #{request_path.green}"
  response = Net::HTTP.start(url, 80) do |http|
    http.get(request_path)
  end

  # status code other than 200 means something wrong happened
  if response.code.to_i != 200
    puts "Received error from server #{response.body}"
    return nil
  end

  puts "Received:\n #{response.body.green}"
  JSON.parse response.body
end

all_client_ids     = DistanceForClient.select(:client_id).map(&:client_id)
known_client_ids   = CorrectedAddress.select(:ClientID).map(&:ClientID)
unknown_client_ids = all_client_ids - known_client_ids

unless unknown_client_ids.empty?
  puts "The following list of client ids are unknown: #{unknown_client_ids.join ", "}".red.bold
end

sorted_clients_ids = (known_client_ids & all_client_ids).sort
sorted_clients_ids.each do |client_id|
  client              = CorrectedAddress.find(client_id)
  other_client_ids    = DistanceForClient.where('client_id > ?', client_id).map(&:client_id)
  existing_client_ids = ClientsDistance.where('client_1_id = ?', client.ClientID).map(&:client_2_id)
  missing_client_ids  = other_client_ids - existing_client_ids

  puts "Calculating distances from client with id #{client_id.to_s.green} to #{missing_client_ids.count.to_s.green} clients"

  other_clients = CorrectedAddress.where('ClientID IN (?)', missing_client_ids)
  other_clients.each_slice(100) do |slice|
    response = get_distances(client, slice)
    response['rows'].first['elements'].zip(slice) do |distance, other_client|
      ClientsDistance.create(:client_1_id => client_id,
                             :client_2_id => other_client.ClientID,
                             :distance => distance['distance']['value'],
                             :time => distance['duration']['value'])
    end
  end
end


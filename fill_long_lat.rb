#!/usr/bin/env ruby

$:.unshift File.dirname(__FILE__)

require 'net/http'
require 'json'
require 'uri'
require 'colombia'
require 'highline/import'

# our valid option for the api argument
def valid_apis
  ['google', 'osm']
end

# Make sure that one argument is provided and it's value is either
# google or osm (open street map)
if ARGV.count != 1 || !valid_apis.include?(ARGV[0])
  puts "Usage: #{$0} geocoding-api"
  puts ""
  puts "where geocoding can be one of:"
  puts "  - google: to use google's geocoding api"
  puts "  - osm: to use open street map geocoding api"
  exit 1
end

# osm requires that the user provide his/her email if
# too many queries are to be made
def email_filename
  "#{ENV['HOME']}/.email_address"
end

# return the email if the email file exist, otherwise print a warning
def _email
  if File.exists?(email_filename)
    email = File.readlines(email_filename).first.strip
    { :email => email }
  else
    puts "================ WARNING ================"
    puts "Make sure you create #{email_filename} with your email in it, otherwise you won't be able to make too many requests to open street map"
    { }
  end
end

# save the email in memory
def email
  @email ||= _email
end

def use_google?
  ARGV[0] == 'google'
end

# the url of the geocoding api
def url
  if use_google?
    'maps.googleapis.com'
  else
    'nominatim.openstreetmap.org'
  end
end

# the rest of the geocoding service path (from the service documentation)
def path
  if use_google?
    '/maps/api/geocode/json'
  else
    '/search'
  end
end

# construct an http request parameters (from the service documentation)
def construct_request address
  params=
    if use_google?
      { :address => address, :region => "CO", :sensor => false }
    else
      email.merge :q => address, :format => "json", :countrycodes => "CO"
    end
  query_params = params.map {|k,v| "#{k.to_s}=#{v.to_s.gsub(' ', '+')}" }.join("&")
  URI.escape "#{path}?#{query_params}"
end

# given an address, construct an http request and get the longitude and latitude
# from either google maps or open street maps. save the returned address in
# memory so we don't have to make the request.
@address_cache = { }
def find_address address
  return @address_cache[address] if @address_cache[address]
  response = Net::HTTP.start(url, 80) do |http|
    request_path = construct_request address
    puts request_path
    http.get(request_path)
  end

  # status code other than 200 means something wrong happened
  if response.code.to_i != 200
    puts "Received error from server #{response.body}"
    return nil
  end

  @address_cache[address] = JSON.parse(response.body)
  @address_cache[address]
end

# from the response, return the longitude and latitude from the first result
def get_lat_long result
  if use_google?
    result = result['results'].first['geometry']['location']
    [result['lat'], result['lng']]
  else
    result = result.first
    [result['lat'], result['lon']] if result
  end
end

# Iterate over all rows with null latitude or longitude and insert the latitude/longitude
# from either google or open street map.
CorrectedAddresses.where('latitude is null or longtitude is null').each do |address|
  puts "address: #{address.CorrectedAddress}, current lat: #{address.MarcoLatitude}, current long: #{address.MarcoLongtitude}"
  osm_addresses = find_address "#{address.CorrectedAddress.strip} bogota"
  next unless osm_addresses
  lat_long = get_lat_long osm_addresses

  next unless lat_long

  lat, long = lat_long

  puts "new lat/long: #{lat}/#{long}"

  address.Longtitude = long
  address.Latitude = lat
  address.save!
end

# print rows that have longitude or latitude different with more than 0.01 from
# the original latitude/longitude (MarcoLatitude/MarcoLongtitude)
CorrectedAddresses.all.each do |addr|
  diff = [addr.MarcoLongtitude - addr.Longtitude, addr.MarcoLatitude - addr.Latitude].map(&:abs).max
  if diff > 0.01
    puts "address: #{addr.CorrectedAddress.strip} bogota, long: #{addr.Longtitude}, lat: #{addr.Latitude}, marco's long: #{addr.MarcoLongtitude}, marco's lat: #{addr.MarcoLatitude}"
  end
end

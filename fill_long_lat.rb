#!/usr/bin/env ruby

$:.unshift File.dirname(__FILE__)

require 'net/http'
require 'json'
require 'uri'
require 'colombia'
require 'highline/import'

def email_filename
  "#{ENV['HOME']}/.email_address"
end

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

def email
  @email ||= _email
end

def use_google?
  !ENV['USE_OSM']
end

def url
  if use_google?
    'maps.googleapis.com'
  else
    'nominatim.openstreetmap.org'
  end
end

def path
  if use_google?
    '/maps/api/geocode/json'
  else
    '/search'
  end
end

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

@address_cache = { }
def find address
  return @address_cache[address] if @address_cache[address]
  response = Net::HTTP.start(url, 80) do |http|
    request_path = construct_request address
    puts request_path
    http.get(request_path)
  end

  # puts response.body

  if response.code.to_i != 200
    puts "Received error from server #{response.body}"
    return nil
  end

  @address_cache[address] = JSON.parse(response.body)
  @address_cache[address]
end

def get_lat_long result
  if use_google?
    result = result['results'].first['geometry']['location']
    [result['lat'], result['lng']]
  else
    result = result.first
    [result['lat'], result['lon']]
  end
end

CorrectedAddresses.where('latitude is null or longtitude is null').each do |adr|
  puts "address: #{adr.CorrectedAddress}, current lat: #{adr.MarcoLatitude}, current long: #{adr.MarcoLongtitude}"
  osm_addresses = find("#{adr.CorrectedAddress.strip} bogota")
  lat, long = get_lat_long osm_addresses

  puts "new lat/long: #{lat}/#{long}"

  adr.Longtitude = long
  adr.Latitude = lat
  adr.save!
end

CorrectedAddresses.all.each do |addr|
  diff = [addr.MarcoLongtitude - addr.Longtitude, addr.MarcoLatitude - addr.Latitude].map(&:abs).max
  if diff > 0.01
    puts "address: #{addr.CorrectedAddress.strip} bogota, long: #{addr.Longtitude}, lat: #{addr.Latitude}, marco's long: #{addr.MarcoLongtitude}, marco's lat: #{addr.MarcoLatitude}"
  end
end

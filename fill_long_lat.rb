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

@address_cache = { }
def find address
  return @address_cache[address] if @address_cache[address]
  params = email.merge :q => address, :format => "json", :countrycodes => "CO"
  query_params = params.map {|k,v| "#{k.to_s}=#{v.to_s.gsub(' ', '+')}" }.join("&")
  path = URI.escape "/search?#{query_params}"

  response = Net::HTTP.start('nominatim.openstreetmap.org', 80) do |http|
    http.get(path)
  end

  # puts path
  # puts response.body

  if response.code.to_i != 200
    puts "Received error from server #{response.body}"
    return nil
  end

  @address_cache[address] = JSON.parse(response.body)
  @address_cache[address]
end

CorrectedAddresses.where('Latitude is null or Longtitude is null').each do |adr|
  puts "address: #{adr.CorrectedAddress}, current lat: #{adr.MarcoLatitude}, current long: #{adr.MarcoLongtitude}"
  osm_addresses = find("#{adr.CorrectedAddress.strip}, #{adr.Town.strip}")
  # chosen_address = nil
  # choose do |menu|
  #   menu.index_suffix = ") "

  #   menu.prompt = "Please choose the closest address ? "

  #   osm_addresses.each do |osm_address|
  #     prompt = "(#{osm_address['lat']}/#{osm_address['lon']}) #{osm_address['display_name']} (#{osm_address['class']}/#{osm_address['type']})"
  #     menu.choice prompt do chosen_address = osm_address end
  #   end
  # end
  chosen_address = osm_addresses.first
  unless chosen_address
    puts "Cannot find #{adr.CorrectedAddress} trying #{adr.Address}"
    osm_addresses = find("#{adr.Address.strip}, #{adr.Town.strip}")
    chosen_address = osm_addresses.first
    unless chosen_address
      puts "Still cannot find #{adr.Address}"
      next
    end
  end
  lon = chosen_address['lon']
  lat = chosen_address['lat']

  puts "Chose #{lat},#{lon} for this address #{adr.CorrectedAddress}"

  adr.Longtitude = lon
  adr.Latitude = lat
  adr.save!
end

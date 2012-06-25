#!/usr/bin/env ruby

$:.unshift File.dirname(__FILE__)

require 'net/http'
require 'json'
require 'cgi'
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
  query_params = params.map {|k,v| CGI.escape(k.to_s)+'='+CGI.escape(v.to_s) }.join("&")

  puts query_params

  response = Net::HTTP.start('nominatim.openstreetmap.org', 80) do |http|
    http.get("/search?#{query_params}")
  end

  @address_cache[address] = JSON.parse(response.body)
  @address_cache[address]
end

CorrectedAddresses.where('Latitude is null or Longtitude is null').each do |adr|
  puts "address: #{adr.CorrectedAddress}, current lat: #{adr.MarcoLatitude}, current long: #{adr.MarcoLongtitude}"
  osm_addresses = find("#{adr.CorrectedAddress} #{adr.Town}")
  chosen_address = nil
  choose do |menu|
    menu.index_suffix = ") "

    menu.prompt = "Please choose the closest address ? "

    osm_addresses.each do |osm_address|
      prompt = "(#{osm_address['lon']}/#{osm_address['lat']}) #{osm_address['display_name']} (#{osm_address['class']}/#{osm_address['type']})"
      menu.choice prompt do chosen_address = osm_address end
    end
  end

  puts "You chose: #{chosen_address}"
end

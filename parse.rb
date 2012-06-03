#!/usr/bin/env ruby

$:.unshift File.dirname(__FILE__)

require 'net/http'
require 'json'
require 'cgi'
require 'colombia'

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

Order.all.each do |order|
  client = order.client
  puts "Address: #{client.Address}" if client
end

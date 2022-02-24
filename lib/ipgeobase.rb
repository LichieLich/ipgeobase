# frozen_string_literal: true

require_relative "ipgeobase/version"
require 'rest-client'
require 'happymapper'

module Ipgeobase
  class Error < StandardError; end
  class IpInformation
    include HappyMapper
    tag 'query'
    element :country, String, tag: 'country'
    element :city, String, tag: 'city'
    element :countryCode, String, tag: 'countryCode'
    element :lat, String, tag: 'lat'
    element :lon, String, tag: 'lon'
  end
  
  def self.lookup(ip)
    check_ip(ip)
    IpInformation.parse(RestClient.get("http://ip-api.com/xml/#{ip}"))
  end

  def self.check_ip(ip)
    raise "IP adress is out of range" if ip.split('.').any? { |ip| ip.to_i > 255 || ip.to_i < 0 }
    raise "IP adress is incorrect" unless ip.split('.').all? { |ip| Float(ip) }
  end
end
# frozen_string_literal: true

require_relative "ipgeobase/version"
require_relative "ip_information"
require 'rest-client'

module Ipgeobase
  IPAPI = "http://ip-api.com/xml/"
  
  def self.lookup(ip)
    check_ip(ip)
    IpInformation.parse(RestClient.get("#{IPAPI}#{ip}"))
  end

  def self.check_ip(ip)
    raise "IP adress is out of range" if ip.split('.').any? { |ip_part| ip_part.to_i > 255 || ip_part.to_i.negative? }
    raise "IP adress is incorrect" unless ip.split('.').all? { |ip_part| Integer(ip_part) }
  end
end

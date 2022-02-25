require 'happymapper'

class IpInformation
  include HappyMapper
  tag 'query'
  element :country, String
  element :city, String
  element :countryCode, String
  element :lat, Float
  element :lon, Float
end

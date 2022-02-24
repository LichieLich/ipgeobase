# frozen_string_literal: true

require "test_helper"

class IpgeobaseTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Ipgeobase::VERSION
  end

  def setup
    response_xml = 
    '<?xml version="1.0" encoding="UTF-8"?>
    <query>
    <status>success</status>
    <country>United States</country>
    <countryCode>US</countryCode>
    <region>VA</region>
    <regionName>Virginia</regionName>
    <city>Ashburn</city>
    <zip>20149</zip>
    <lat>39.03</lat>
    <lon>-77.5</lon>
    <timezone>America/New_York</timezone>
    <isp>Google LLC</isp>
    <org>Google Public DNS</org>
    <as>AS15169 Google LLC</as>
    <query>8.8.8.8</query>
    </query>'
    stub_get = stub_request(:get, "http://ip-api.com/xml/8.8.8.8").to_return(body: response_xml, status: 200)
    @ip_meta = Ipgeobase.lookup('8.8.8.8')
    remove_request_stub stub_get
  end

  def test_that_it_has_valid_info
    assert_equal 'Ashburn', @ip_meta.city
    assert_equal 'United States', @ip_meta.country
    assert_equal 'US', @ip_meta.countryCode
    assert_equal '39.03', @ip_meta.lat
    assert_equal '-77.5', @ip_meta.lon
  end

  def test_it_raises_ip_out_of_range_error
    assert_raises { Ipgeobase.lookup('-1.8.8.8') }
    assert_raises { Ipgeobase.lookup('1.8.822.8') }
  end

  def test_it_raises_incorrect_ip_error
    assert_raises { Ipgeobase.lookup('8.8.a.8') }
  end
end

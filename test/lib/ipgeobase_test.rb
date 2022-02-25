# frozen_string_literal: true

require "test_helper"

class IpgeobaseTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Ipgeobase::VERSION
  end

  def setup
    response_xml = File.open('./fixture/files/test_request.xml', 'r'){ |file| file.read }
    stub_request(:get, "#{Ipgeobase::IPAPI}8.8.8.8").to_return(body: response_xml, status: 200)
    @ip_meta = Ipgeobase.lookup('8.8.8.8')
  end

  def test_that_it_has_valid_info
    assert_equal 'Ashburn', @ip_meta.city
    assert_equal 'United States', @ip_meta.country
    assert_equal 'US', @ip_meta.countryCode
    assert_equal 39.03, @ip_meta.lat
    assert_equal -77.5, @ip_meta.lon
  end

  def test_it_raises_ip_out_of_range_error
    assert_raises { Ipgeobase.lookup('-1.8.8.8') }
    assert_raises { Ipgeobase.lookup('1.8.822.8') }
  end

  def test_it_raises_incorrect_ip_error
    assert_raises { Ipgeobase.lookup('8.8.a.8') }
  end
end

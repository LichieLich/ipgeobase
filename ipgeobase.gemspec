# frozen_string_literal: true

require_relative "lib/ipgeobase/version"

Gem::Specification.new do |spec|
  spec.name = "ipgeobase"
  spec.version = Ipgeobase::VERSION
  spec.authors = ["LichieLich"]
  spec.email = ["lichie_lich@mail.ru"]

  spec.summary = "Gem helps tp retrieve metainformation about IP"
  spec.description = "Ipgeobase uses ip-api.com to get information about any IP, such as country, city, countryCode, latitude and longitude"
  spec.homepage = "https://github.com/LichieLich/ipgeobase"
  spec.required_ruby_version = ">= 3.0.2"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/LichieLich/ipgeobase"
  spec.metadata["changelog_uri"] = "https://github.com/LichieLich/ipgeobase"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "nokogiri-happymapper"
  spec.add_dependency "rest-client"
  spec.add_dependency "webmock"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end

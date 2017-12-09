source ENV['GEM_SOURCE'] || 'https://rubygems.org'

puppetversion = ENV.key?('PUPPET_VERSION') ? ENV['PUPPET_VERSION'] : ['5.0.1']
gem 'puppet', puppetversion

gem 'puppetlabs_spec_helper', '2.3.1'
gem 'rake', '12.0.0'
gem 'rspec-puppet', '2.6.7'

group :rubocop do
  gem 'rubocop', '0.51.0'
  gem 'rubocop-rspec', '1.10.0'
end

group :testing do
  gem 'metadata-json-lint', '1.2.2'
  gem 'rspec-puppet-facts', '1.8.0'
end

group :acceptance do
  gem 'bcrypt_pbkdf', '1.0.0'
  gem 'beaker', '3.28.0'
  gem 'beaker-rspec', '6.1.0'
  gem 'rbnacl', '4.0.2'
  gem 'rbnacl-libsodium', '1.0.13'
  gem 'serverspec', '2.40.0'
  gem 'specinfra', '2.70.1'
end

group :development do
  gem 'travis',      :require => false
  gem 'travis-lint', :require => false
end

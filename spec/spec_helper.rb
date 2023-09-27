require 'vcr'

RSpec.configure do |config|
  config.before(:suite) do
    VCR.configure do |vcr_config|
      vcr_config.cassette_library_dir = "spec/vcr_cassettes"
      vcr_config.hook_into :webmock
    end
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end

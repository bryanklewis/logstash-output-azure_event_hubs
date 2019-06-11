GEM_VERSION = File.read(File.expand_path(File.join(File.dirname(__FILE__), "VERSION"))).strip unless defined?(GEM_VERSION)

Gem::Specification.new do |s|
  s.name          = 'logstash-output-azure_event_hubs'
  s.version       = GEM_VERSION
  s.licenses      = ['Apache-2.0']
  s.summary       = 'Writes events to Azure Event Hubs'
  s.description   = 'This is a Logstash output plugin used to write events to an Azure Event Hub'
  s.homepage      = 'https://github.com/bryanklewis/logstash-output-azure_event_hubs'
  s.authors       = ['Bryan Lewis']
  s.email         = 'dbre@micron.com'
  s.require_paths = ['lib', 'vendor/jar-dependencies']

  # Files
  s.files = Dir['lib/**/*', 'spec/**/*', 'vendor/jar-dependencies/**/*.jar', 'vendor/jar-dependencies/**/*.rb', '*.gemspec', '*.md', 'CONTRIBUTORS', 'Gemfile', 'LICENSE', 'VERSION', 'NOTICE']

  # Tests
  s.test_files = s.files.grep(%r{^(test|spec|features)/})

  # Metadata "logstash_* => .." are special flags to indicate this a logstash plugin
  s.metadata = {
    "logstash_plugin" => "true",
    "logstash_group" => "output",
    "source_code_uri" => "https://github.com/bryanklewis/logstash-output-azure_event_hubs",
    "allowed_push_host" => "rubygems.org"
  }

  # Gem dependencies
  s.add_runtime_dependency "logstash-core-plugin-api", "~> 2.0"
  s.add_runtime_dependency 'logstash-codec-plain'
  s.add_runtime_dependency 'logstash-codec-json'

  s.add_development_dependency 'logstash-devutils'

  # Jar dependencies
  s.add_development_dependency 'jar-dependencies'
end

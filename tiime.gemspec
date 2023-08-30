# frozen_string_literal: true

require_relative 'lib/tiime/version'

Gem::Specification.new do |spec|
  spec.name          = 'tiime'
  spec.version       = Tiime::VERSION
  spec.authors       = ['Manuel Tancoigne', 'Romuald Conty']
  spec.email         = ['manu@opus-labs.fr', 'romuald@opus-labs.fr']

  spec.summary       = 'Tiime client'
  spec.description   = 'REST client for the Tiime API'
  spec.required_ruby_version = Gem::Requirement.new('>= 3.0.0')

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'faraday-gzip'
  spec.add_dependency 'flexirest'

  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
  spec.metadata['rubygems_mfa_required'] = 'true'
end

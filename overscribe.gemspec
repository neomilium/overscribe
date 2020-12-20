require_relative 'lib/overscribe/version'

Gem::Specification.new do |spec|
  spec.name          = 'overscribe'
  spec.version       = Overscribe::VERSION
  spec.authors       = ['Romuald Conty']
  spec.email         = ['romuald@opus-codium.fr']

  spec.summary       = 'Keep your favorites media synced'
  spec.description   = 'A tool to download online media like youtube playlists'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.5.0')

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'thor'

  spec.add_development_dependency 'byebug'
  spec.add_development_dependency 'rubocop'
end

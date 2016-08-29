lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mina/ci/version'

Gem::Specification.new do |spec|
  spec.name          = 'mina-ci'
  spec.version       = Mina::Ci::VERSION
  spec.authors       = ['Sean Dong']
  spec.email         = ['sindon@gmail.com']
  spec.summary       = %q{Mina recipe for checking Circle CI build status}
  spec.description   = %q{Mina recipe for checking Circle CI build status of your repo.}
  spec.homepage      = 'https://github.com/seandong/mina-ci'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency     'mina',    '~> 1.0'

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake',    '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
end

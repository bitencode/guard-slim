# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "guard/slim/version"

Gem::Specification.new do |s|
  s.name        = "guard-slim"
  s.version     = Guard::SlimVersion::VERSION
  s.platform    = Gem::Platform::RUBY
  s.license     = 'MIT'
  s.authors     = ["Florian Aßmann", "John Manuel"]
  s.email       = ["florian.assmann@email.de", "bitencode@johnmanuel.org"]
  s.homepage    = ""
  s.summary     = 'Guard plugin to render Slim templates'
  s.description = 'Compiles file.html.slim to file.html'

  s.required_ruby_version = '>= 1.9.3'

  s.files         = Dir['{lib}/**/*'] #= `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'guard', '~> 2.0'
  s.add_dependency 'slim',  '>= 2.0'
end

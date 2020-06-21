# encoding: utf-8
$:.push File.expand_path('../lib', __FILE__)

Dir.chdir(__dir__) do
  Gem::Specification.new do |gem|
    gem.name        = 'fluent-plugin-sql-enhanced'
    gem.description = 'Enhanced SQL input/output plugin for Fluentd event collector'
    gem.homepage    = 'https://github.com/ThryveWork/fluent-plugin-sql-enhanced'
    gem.summary     = gem.description
    gem.version     = File.read('VERSION').strip
    gem.authors     = ['Jon Frisby']
    gem.email       = 'jon@thryve.work'
    gem.license     = 'Proprietary'
    #gem.platform    = Gem::Platform::RUBY

    gem.files         = `git ls-files -z`.split("\x0")
    gem.test_files    = `git ls-files -z -- {test,spec,features}/*`.split("\x0")
    gem.executables   = `git ls-files -z -- bin/*`.split("\x0").map{ |f| File.basename(f) }
    gem.require_paths = ['lib']

    gem.add_dependency 'fluentd', ['>= 0.12.17', '< 2']
    gem.add_dependency 'activerecord', '~> 5.1'
    gem.add_dependency 'activerecord-import', '~> 0.7'
    gem.add_development_dependency 'rake', '>= 0.9.2'
    gem.add_development_dependency 'test-unit', '> 3.1.0'
    gem.add_development_dependency 'test-unit-rr'
    gem.add_development_dependency 'test-unit-notify'
    gem.add_development_dependency 'pg', '~> 1.0'
  end
end

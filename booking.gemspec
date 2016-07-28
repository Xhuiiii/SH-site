$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "booking/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "booking"
  s.version     = Booking::VERSION
  s.authors     = ["Xhuiiii"]
  s.email       = ["robyn.jh.liu@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Booking."
  s.description = "TODO: Description of Booking."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.5"

  s.add_development_dependency "sqlite3"
end

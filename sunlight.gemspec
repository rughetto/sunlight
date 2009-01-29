Gem::Specification.new do |s|
  s.name = "sunlight"
  s.version = "0.1.1"
  s.date = "2009-01-28"
  s.summary = "Library for accessing the Sunlight Labs API."
  s.email = "ru_ghetto@rubyghetto.com"
  s.homepage = "http://github.com/rughetto/sunlight"
  s.authors = ["Luigi Montanez", "Rue the Ghetto"]
  s.files = [
    'sunlight.gemspec', 
    'lib/sunlight.rb', 
    'lib/sunlight/sunlight_object.rb', 
    'lib/sunlight/district.rb', 
    'lib/sunlight/legislator.rb', 
    'README.textile', 
    'CHANGES.textile']
  s.add_dependency("json", [">= 1.1.3"])
  s.add_dependency("ym4r", [">= 0.6.1"])
  s.has_rdoc = true
end
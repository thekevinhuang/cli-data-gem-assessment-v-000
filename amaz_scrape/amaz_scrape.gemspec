
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "amaz_scrape/version"

Gem::Specification.new do |spec|
  spec.name          = "amaz_scrape"
  spec.version       = AmazScrape::VERSION
  spec.authors       = ["'Kevin Huang'"]
  spec.email         = ["'yellow.khaos@gmail.com'"]

  spec.summary       = "Scrapes Amazon for up to 10 items allowing users to drill down and explore details"
  spec.description   = "Running amaz_scrape will prompt the user to follow CLI instructions to type a product to scrape, and explore a menu of items"
  spec.homepage      = "https://github.com/thekevinhuang/cli-data-gem-assessment-v-000"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
end

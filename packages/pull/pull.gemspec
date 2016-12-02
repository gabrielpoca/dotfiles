# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "pull/version"

Gem::Specification.new do |spec|
  spec.name = "pull"
  spec.version = Pull::VERSION
  spec.authors = ["Gabriel Poça"]
  spec.email = ["gabrielpoca@gmail.com"]

  spec.summary = "Custom commands for pull requests"
  spec.description = "Custom commands for pull requests"
  spec.homepage = "https://github.com/gabrielpoca/dotfiles"
  spec.license = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files = ["lib/pull.rb", "lib/pull/version.rb"]
  spec.executables << "pull"
  spec.require_paths = ["lib"]

  spec.add_dependency "netrc"
  spec.add_dependency "octokit"
  spec.add_dependency "git"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
end

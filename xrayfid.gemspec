# frozen_string_literal: true

require_relative "lib/xrayfid/version"

Gem::Specification.new do |spec|
  spec.name = "xrayfid"
  spec.version = Xrayfid::VERSION
  spec.authors = ["Takahiro SATOH"]
  spec.email = ["zalt50cc@gmail.com"]

  spec.summary = "A Ruby interface to xraylib powered by Fiddle"
  spec.description = "This gem provides a Ruby interface to xraylib for the interaction of X-rays with matter, using Fiddle instead of SWIG."
  spec.homepage = "https://github.com/zalt50/xrayfid"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/zalt50/xrayfid.git"
  spec.metadata["changelog_uri"] = "https://raw.githubusercontent.com/zalt50/xrayfid/main/CHANGELOG.md"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "fast_underscore", "~> 0.3"
end

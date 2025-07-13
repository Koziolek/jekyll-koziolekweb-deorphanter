# frozen_string_literal: true

require_relative "lib/jekyll/koziolekweb/deorphanter/version"

Gem::Specification.new do |spec|
  spec.name = "jekyll-koziolekweb-deorphanter"
  spec.version = Jekyll::Koziolekweb::Deorphanter::VERSION
  spec.authors = ["Koziolek"]
  spec.email = ["bjkuczynski@gmail.com"]

  spec.summary = "Plugin that replaces spaces after single letter with &nbsp;"
  spec.description = "Plugin that replaces spaces after single letter with &nbsp; that helps to avoid living single letter at the end of a line."
  spec.homepage = "https://github.com/Koziolek/jekyll-koziolekweb-deorphanter"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.4.0"
  spec.add_dependency "jekyll", ">= 3.7", "< 5.0"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.metadata["source_code_uri"] = "https://github.com/Koziolek/jekyll-koziolekweb-deorphanter"
  spec.metadata["changelog_uri"] = "https://github.com/Koziolek/jekyll-koziolekweb-deorphanter/CHANGELOG.md"


  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end

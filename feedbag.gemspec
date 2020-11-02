# -*- encoding: utf-8 -*-
# stub: feedbag 0.9.5 ruby lib

Gem::Specification.new do |s|
  s.name = "feedbag"
  s.version = "0.9.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["David Moreno", "Derek Willis"]
  s.date = "2014-10-16"
  s.description = "Ruby's favorite feed auto-discoverty tool"
  s.email = "david@axiombox.com"
  s.executables = ["feedbag"]
  s.extra_rdoc_files = ["README.markdown", "COPYING"]
  s.files = ["COPYING", "README.markdown", "benchmark/rfeedfinder_benchmark.rb", "bin/feedbag", "lib/feedbag.rb"]
  s.homepage = "http://github.com/damog/feedbag"
  s.licenses = ["MIT"]
  s.rdoc_options = ["--main", "README.markdown"]
  s.rubyforge_project = "feedbag"
  s.rubygems_version = "2.5.1"
  s.summary = "Ruby's favorite feed auto-discovery tool"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<nokogiri>, ["~> 1.0"])
      s.add_runtime_dependency(%q<open_uri_redirections>, ["= 0.2.1"])
      s.add_runtime_dependency(%q<feedvalidator>, ["~> 0.2"])
      s.add_development_dependency(%q<shoulda>, ["~> 0"])
      s.add_development_dependency(%q<mocha>, [">= 0.12.0", "~> 0.12"])
    else
      s.add_dependency(%q<nokogiri>, ["~> 1.0"])
      s.add_dependency(%q<open_uri_redirections>, ["= 0.2.1"])
      s.add_dependency(%q<feedvalidator>, ["~> 0.2"])
      s.add_dependency(%q<shoulda>, ["~> 0"])
      s.add_dependency(%q<mocha>, [">= 0.12.0", "~> 0.12"])
    end
  else
    s.add_dependency(%q<nokogiri>, ["~> 1.0"])
    s.add_dependency(%q<open_uri_redirections>, ["= 0.2.1"])
    s.add_dependency(%q<feedvalidator>, ["~> 0.2"])
    s.add_dependency(%q<shoulda>, ["~> 0"])
    s.add_dependency(%q<mocha>, [">= 0.12.0", "~> 0.12"])
  end
end

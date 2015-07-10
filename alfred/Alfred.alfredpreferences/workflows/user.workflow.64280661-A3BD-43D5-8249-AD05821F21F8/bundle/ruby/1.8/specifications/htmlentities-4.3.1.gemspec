# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{htmlentities}
  s.version = "4.3.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Paul Battley"]
  s.date = %q{2011-11-30}
  s.email = %q{pbattley@gmail.com}
  s.files = ["test/html4_test.rb", "test/ruby_1_8_test.rb", "test/roundtrip_test.rb", "test/encoding_test.rb", "test/xhtml1_test.rb", "test/decoding_test.rb", "test/ruby_1_9_test.rb", "test/expanded_test.rb", "test/entities_test.rb", "test/interoperability_test.rb"]
  s.homepage = %q{https://github.com/threedaymonk/htmlentities}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{A module for encoding and decoding (X)HTML entities.}
  s.test_files = ["test/html4_test.rb", "test/ruby_1_8_test.rb", "test/roundtrip_test.rb", "test/encoding_test.rb", "test/xhtml1_test.rb", "test/decoding_test.rb", "test/ruby_1_9_test.rb", "test/expanded_test.rb", "test/entities_test.rb", "test/interoperability_test.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end

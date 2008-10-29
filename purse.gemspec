(in /Users/aaronquint/Sites/purse)
Gem::Specification.new do |s|
  s.name = %q{purse}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Aaron Quint"]
  s.date = %q{2008-10-29}
  s.default_executable = %q{purse}
  s.description = %q{A simple but secure password storage solution using git and crypt}
  s.email = ["aaron@quirkey.com"]
  s.executables = ["purse"]
  s.extra_rdoc_files = ["History.txt", "License.txt", "Manifest.txt", "PostInstall.txt", "README.txt", "lib/purse/help.txt"]
  s.files = ["History.txt", "License.txt", "Manifest.txt", "PostInstall.txt", "README.txt", "Rakefile", "bin/purse", "lib/purse.rb", "lib/purse/cli.rb", "lib/purse/error.rb", "lib/purse/note.rb", "lib/purse/pocket.rb", "lib/purse/settings.rb", "lib/purse/version.rb", "lib/purse/help.txt", "test/purse/test_cli.rb", "test/purse/test_note.rb", "test/purse/test_pocket.rb", "test/purse/test_settings.rb", "test/test_helper.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://quirkey.rubyforge.org}
  s.post_install_message = %q{
For more information on purse, see http://quirkey.com/blog
}
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{quirkey}
  s.rubygems_version = %q{1.2.0}
  s.summary = %q{A simple but secure password storage solution using git and crypt}
  s.test_files = ["test/purse/test_cli.rb", "test/purse/test_note.rb", "test/purse/test_pocket.rb", "test/purse/test_settings.rb", "test/test_helper.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if current_version >= 3 then
      s.add_development_dependency(%q<hoe>, [">= 1.8.2"])
    else
      s.add_dependency(%q<hoe>, [">= 1.8.2"])
    end
  else
    s.add_dependency(%q<hoe>, [">= 1.8.2"])
  end
end

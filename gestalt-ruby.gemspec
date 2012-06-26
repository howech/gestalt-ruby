spec = Gem::Specification.new do |s|
  s.name = 'gestalt-ruby'
  s.version = '0.0.0'
  s.summary = "Gestalt configuration library"
  s.description = %{Event driven configuration library.}
  s.files = Dir['lib/**/*.rb'] + Dir['test/**/*.rb']
  s.require_path = 'lib'
  s.autorequire = 'gestalt-conf'
  s.has_rdoc = true
  s.extra_rdoc_files = Dir['[A-Z]*']
  s.rdoc_options << '--title' <<  'Gestalt-ruby -- Event driven configuration'
  s.author = "Chris Howe"
  s.email = "chris@howeville.com"
  s.homepage = "https://github.com/howech/gestalt-ruby"
end
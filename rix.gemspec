$:.unshift 'lib'

require 'rix'

Gem::Specification.new do |s|
  s.name = 'rix'
  s.version = Rix::VERSION
  s.author = 'Richard Hubers'
  s.date = Time.now.strftime('%Y-%m-%d')
  s.description = 'Command-line XML editing and refactoring'
  s.summary = 'Command-line XML editor'
  s.email = 'richard.hubers@gmail.com'
  s.required_ruby_version = '>=1.9'
  s.files = Dir['README', 'bin/rix', 'lib/**/*']
  s.executables = ['rix']
  s.homepage = 'http://github.com/rh/rix'
  s.has_rdoc = false
end

begin
  require 'interactive_editor'
rescue LoadError
  puts "Installing interactive_editor gem..."
  `gem install interactive_editor`

  puts "Please restart irb"
  exit
end

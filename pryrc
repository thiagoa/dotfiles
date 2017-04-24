Pry.config.editor = "nvim"
Pry.prompt = [proc { |obj, nest_level| "#{RUBY_VERSION} (#{obj}):#{nest_level} > " }, proc { |obj, nest_level| "#{RUBY_VERSION} (#{obj}):#{nest_level} * " }]

begin
  require 'awesome_print'
rescue LoadError
  puts 'Installing awesome_print...'
  `gem install awesome_print`

  puts 'Please restart pry'
  exit
end

AwesomePrint.pry!

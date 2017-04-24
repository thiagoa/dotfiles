require 'pathname'

Pry.config.editor = "nvim"

Pry.prompt = [
  proc { |obj, nest_level| "#{RUBY_VERSION} (#{obj}):#{nest_level} > " },
  proc { |obj, nest_level| "#{RUBY_VERSION} (#{obj}):#{nest_level} * " }
]

begin
  if Pathname(Dir.pwd).join('Gemfile').exist? && $0 != 'pry'
    # I don't want awesome_print polluting Gemfile, so require it manually from
    # the gems path.  I wish there was a simpler solution to this problem.
    awesome_print_path = Pathname(Gem.path.first)
      .join('gems')
      .children
      .map(&:to_s)
      .find { |path| path =~ /awesome_print/ }

    fail LoadError unless awesome_print_path

    require File.join(awesome_print_path, 'lib', 'awesome_print')
  else
    require 'awesome_print'
  end
rescue LoadError
  puts 'Installing awesome_print...'

  `zsh -c "gem install awesome_print"`

  puts 'Please restart pry'
  exit
end

AwesomePrint.pry!

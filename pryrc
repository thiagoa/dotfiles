require 'pathname'

Pry.config.editor = ENV['VISUAL']

def emacs_open_in_dired(source_location)
  system %{emacsclient -e '(dired-jump nil "#{source_location}")'}
end

def emacs_find_with_ag(string, directory)
  system %{emacsclient -e '(ag "#{string}" "#{directory}")'}
end

def gem_dir(gem_name)
  Pathname(Gem::Specification.find_by_name(gem_name).gem_dir)
end

Pry::Commands.create_command 'dired' do
  description 'Open in Emacs dired'

  def options(opt)
    opt.on :r, :root, "Open at the project's root"
  end

  def process
    source_location = find_source_location
    return if source_location.nil?
    emacs_open_in_dired source_location
  end

  def find_source_location
    code = Pry::CodeObject.lookup(args.join(''), _pry_)
    return unless code
    location = code.source_location.first

    if opts.root?
      parts = location.split('/')

      begin
        path = Pathname(parts.join('/'))
        return (path / 'lib') if (path / 'Gemfile').exist?
      end while parts.pop
    else
      return location
    end
  end
end

Pry::Commands.create_command 'ggem' do
  description 'Open a gem dir in Emacs dired'

  def process
    gem_name = args.join('')
    emacs_open_in_dired gem_dir(gem_name) / 'lib'
  rescue Gem::MissingSpecError
    # do nothing
  end
end

Pry::Commands.create_command 'fgem' do
  description "Find within a gem dir with ag"

  def process
    emacs_find_with_ag args[1], gem_dir(args[0])
  rescue Gem::MissingSpecError
    # do nothing
  end
end

class PryViewCommand < Pry::Command::Edit
  match 'view'
  description 'Edit a file but return to the prompt immediately'

  def process
    original_editor = Pry.config.editor
    Pry.config.editor = ENV.fetch('VIEW_VISUAL', 'emacsclient -n')
    super
    Pry.config.editor = original_editor
  end
end

Pry::Commands.add_command PryViewCommand

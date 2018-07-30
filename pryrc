require 'pathname'

if ENV['INSIDE_EMACS']
  Pry.config.correct_indent = false
  Pry.config.pager = false
end

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
  banner <<-'BANNER'
  Usage: ggem PRY_TERM

  Example: ggem Propono (places the cursor in dired where the file is)
  BANNER

  def process
    gem_name = args.join('')
    emacs_open_in_dired gem_dir(gem_name) / 'lib'
  rescue Gem::MissingSpecError
    # do nothing
  end
end

Pry::Commands.create_command 'fgem' do
  description "Find with ag inside a gem's dir"
  banner <<-'BANNER'
  Usage: fgem GEM_NAME SEARCH_TERM
  BANNER

  def process
    gem_name, search_term = args
    emacs_find_with_ag search_term, gem_dir(gem_name)
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

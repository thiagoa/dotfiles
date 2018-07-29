require 'pathname'

Pry.config.editor = ENV['VISUAL']

class PryViewCommand < Pry::Command::Edit
  match 'view'

  def process
    original_editor = Pry.config.editor
    Pry.config.editor = ENV.fetch('VIEW_VISUAL', 'emacsclient -n')
    super
    Pry.config.editor = original_editor
  end
end

Pry::Commands.add_command PryViewCommand

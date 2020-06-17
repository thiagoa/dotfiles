cheatsheet do
  title 'Pry'
  docset_file_name 'Pry'
  keyword 'wtf?'
  
  introduction "Ruby's Pry gem"

  category do
    id 'Pry'

    entry do
      command 'help ls'
      name 'Help'
      notes 'Display help about the ls command'
    end

    entry do
      command 'ls <Object>'
      name 'Methods'
      notes 'Show the available methods for <Object>'
    end

    entry do
      command '_'
      name 'Last eval'
      notes 'Result of the last command evaluated'
    end

    entry do
      command '? <Object>'
      name 'More info'
      notes 'Shows more information about and object or method'
    end

    entry do
      command '_file_'
      name 'Last file'
      notes 'Represents the last file touched by Pry'
    end

    entry do
      command 'wtf?'
      name 'Stack trace'
      notes 'Prints the current stack trace'
    end

    entry do
      command '$'
      name 'Show source'
      notes 'Shortcut for show-source'
    end

    entry do
      command 'edit Class'
      name 'Edit class'
      notes 'Open class in $EDITOR'
    end

    entry do
      command '<ctrl+r>'
      name 'Search history'
    end

    entry do
      command '_out_'
      name 'Output values'
      notes 'Array of all output values. also \_in\_'
    end

    entry do
      command 'cd <var>'
      name 'Change the value of self'
      notes 'Steps into an object'
    end

    entry do
      command 'cd ..'
      name 'Take out of a level'
    end

    entry do
      command '.<Shell>'
      name 'Runs a shell command'
    end

    entry do
      command 'play -l'
      name 'Execute the line in the current debugging context'
      notes 'Display help about the ls command'
    end

    entry do
      command 'whereami <n-lines>'
      name 'Print code context'
      notes '<n-lines> is optional and represents the no. of surrounding lines of context'
    end
    
    entry do
      command ';'
      name 'Mute return value'
      notes 'Mute the return output by Ruby'
    end
  end
end

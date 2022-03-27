# Use double underscore to get a history array
IRB.conf[:EVAL_HISTORY] = 6
IRB.conf[:USE_MULTILINE] = false if ENV['INSIDE_EMACS']
IRB.conf[:USE_READLINE] = false if ENV['INSIDE_EMACS']

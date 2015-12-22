# If a new command line being added to the history list duplicates an older one, the older command
# is removed from the list
setopt histignorealldups

# remove command lines from the history list when the first character on the line is a space
setopt histignorespace

# avoid "beep"ing
setopt nobeep

# Typically, compinit will not automatically find new executables in the $PATH. For example, after
# you install a new package, the files in /usr/bin would not be immediately or automatically
# included in the completion. Thus, to have these new exectuables included, one would run "rehash".
# This rehash can be set to happen automatically. 
setopt nohashdirs
setopt nohashcmds

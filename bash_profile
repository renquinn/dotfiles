#  ---------------------------------------------------------------------------
#
#  Description:  BASH configurations, paths, and aliases
#
#  Sections:
#  1.   Environment Configuration
#  2.   Paths
#  3.   Aliases
#  4.   Web Development
#  5.   Git
#  6.   Ruby
#
#  ---------------------------------------------------------------------------

#   -------------------------------
#   1.  ENVIRONMENT CONFIGURATION
#   -------------------------------

#   History
#   ------------------------------------------------------------
    export HISTCONTROL=erasedups
    export HISTSIZE=1000 # 1000 is default anyway
    shopt -s histappend

#   Prompt
#   ------------------------------------------------------------
    export PS1="\u@\h \w $ "

#   Default Editor
#   ------------------------------------------------------------
    export EDITOR=/usr/bin/vim

#   Display colors
#   ------------------------------------------------------------
    export CLICOLOR=1
    #export LSCOLORS=ExFxCxDxBxegedabagacad
    export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

#   -------------------------------
#   2.  PATHS
#   -------------------------------

#   Android
#   ------------------------------------------------------------
    export PATH="$HOME/Code/android-sdk/tools:$PATH"
    export PATH="$HOME/Code/android-sdk/platform-tools:$PATH"

#   Go
#   ------------------------------------------------------------
    export GOROOT=/usr/local/go
    export PATH=$PATH:$GOROOT/bin

#   App Engine
#   ------------------------------------------------------------
    export PATH="$HOME/Code/appengine:$PATH"
    export PATH="$HOME/Code/go_appengine:$PATH" # newer version

#   rbenv
#   ------------------------------------------------------------
    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"

#   Gems
#   ------------------------------------------------------------
    export PATH="/Users/renquinn/.rbenv/versions/1.9.3-p484/bin:$PATH"

#   Custom Clips
#   ------------------------------------------------------------
    export PATH="$HOME/School/clips-instrumented:$PATH"

#   ---------------------------------------
#   3.  ALIASES
#   ---------------------------------------

#   Flux Printer
#   ------------------------------------------------------------
    alias printer='ssh -N -f -L 9100:155.98.60.195:9100 bas.flux.utah.edu'

#   ---------------------------------------
#   4.  WEB DEVELOPMENT
#   ---------------------------------------

    alias apacheEdit='sudo edit /etc/httpd/httpd.conf'      # apacheEdit:       Edit httpd.conf
    alias apacheRestart='sudo apachectl graceful'           # apacheRestart:    Restart Apache
    alias editHosts='sudo edit /etc/hosts'                  # editHosts:        Edit /etc/hosts file

#   ---------------------------------------
#   5.  GIT
#   ---------------------------------------

#   Init
#   ------------------------------------------------------------
    source ~/.git-completion.bash

#   Misc
#   ------------------------------------------------------------
    function gitdelete() { # Call git rm on all deleted files
        for item in $(git status | grep deleted | awk '{ print $2 }'); do
            echo "git rm $item";
        done
    }

#   ---------------------------------------
#   6.  RUBY
#   ---------------------------------------

#   Path
#   ------------------------------------------------------------
    #export PATH="$HOME/.rbenv/bin:/usr/local/mysql/bin:$PATH"
    #eval "$(rbenv init -)"
    #export DYLD_LIBRARY_PATH="/usr/local/mysql/lib:$DYLD_LIBRARY_PATH"

#   Aliases
#   ------------------------------------------------------------
    #alias rails="bin/rails"
    #alias b="bundle"
    #alias bi="bundle install --path vendor/bundle --binstubs"
    #alias bil="bi --local"
    #alias bu="b update"
    #alias be="b exec"
    #alias binit="bi && b package && echo 'vendor/ruby'>>.gitignore"

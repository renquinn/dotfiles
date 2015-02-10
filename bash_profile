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
    export PS1="\u@\h \w \$ "

#   Default Editor
#   ------------------------------------------------------------
    export EDITOR=/usr/bin/vim

#   Display colors
#   ------------------------------------------------------------
    export CLICOLOR=1
    #export LSCOLORS=ExFxCxDxBxegedabagacad
    export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

#   Find and Replace
#   ------------------------------------------------------------
    # Find and replace over all files in current directory
    function fandr() {
        if [ "$#" -ne 3 ]
        then
            echo "Usage: fandr <file(s)> <old_string> <new_string>"
        else
            #find . -type f -exec sed -i "s/$1/$2/g" {} \;
            for file in $1; do
                mv $file $file.old
                sed 's/$2/$3/g' $file.old > $file
                rm -f $file.old
            done
        fi
    }

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
    export GOPATH=$HOME/Code/go
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

#   Racket
#   ------------------------------------------------------------
    export PATH="/Applications/Racket v6.0.1/bin:$PATH"

#   ---------------------------------------
#   3.  ALIASES
#   ---------------------------------------

#   Android
#   ------------------------------------------------------------
    adbinstallm() {
        if [ "$#" -ne 1 ]; then
            echo "usage: adbinstallm <apk>"
        else
            adb devices | tail -n 3 | head -n 2 | awk '{ print $1 }' | xargs -IX adb -s X install -r $1
        fi
    }

#   Flux Printer
#   ------------------------------------------------------------
    alias printer='ssh -N -f -L 9100:155.98.60.195:9100 bas.flux.utah.edu'

#   App Engine
#   ------------------------------------------------------------
    alias goappd='appcfg.py --oauth2 update .'

#   Racket
#   ------------------------------------------------------------
    alias irkt='racket -il xrepl'

#   PDF2TXT
#   ------------------------------------------------------------
    pdf2txt() {
        if [ "$#" -ne 1 ]; then
            echo "usage: pdf2txt <filename>"
        else
            FILE=${1%.*}
            echo "Preprocessing. . ."
            pdf2ps $1 $FILE.ps
            echo "Finalizing output. . ."
            ps2ascii $FILE.ps > $FILE.txt
            rm $FILE.ps
            echo "Done. New file at: $FILE.txt"
        fi
    }

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

#   Vim Profiling
#   ------------------------------------------------------------
    alias vimp="vim --startuptime ~/Desktop/vim_startup_report.txt"

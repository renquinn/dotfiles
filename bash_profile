#  ---------------------------------------------------------------------------
#
#  Description:  BASH configurations, paths, and aliases
#
#  Sections:
#  1.   Environment Configuration
#  2.   Paths
#  3.   Aliases and Functions
#  4.   Web Development
#  5.   Git
#  6.   Docker
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
    export PS1="\u@\h \w \n[\T] \$ "

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

#   Misc Aliases
#   ------------------------------------------------------------
    alias grep='grep --color=auto'

#   -------------------------------
#   2.  PATHS
#   -------------------------------

#   Android
#   ------------------------------------------------------------
    export PATH="$HOME/.android-sdk/tools:$PATH"
    export PATH="$HOME/.android-sdk/build-tools:$PATH"
    export PATH="$HOME/.android-sdk/platform-tools:$PATH"

#   Go
#   ------------------------------------------------------------
    export GOROOT=/usr/local/go
    export GOPATH=$HOME/Code/go
    export PATH=$PATH:$GOROOT/bin

#   App Engine
#   ------------------------------------------------------------
    export PATH="$HOME/.go_appengine:$PATH" # newer version

#   Custom Clips
#   ------------------------------------------------------------
    export PATH="$HOME/School/clips-instrumented:$PATH"

#   Racket
#   ------------------------------------------------------------
    export PATH="/Applications/Racket v6.0.1/bin:$PATH"

#   ---------------------------------------
#   3.  ALIASES and FUNCTIONS
#   ---------------------------------------

cmds() {
    echo "adbinstallm         - installs an apk on multiple connected android devices"
    echo "goappd              - deploys current folder to appengine"
    echo "printer             - initializes connection to flux printer"
    echo "gdvim               - opens google docs document in vim"
    echo "vim-html-markdown   - edit markdown file in vim, then save as html"
    echo "irkt                - open racket repl"
    echo "pdf2txt             - converts pdf document to txt document"
    echo "camera_fix          - resets macbook camera when malfunctioning"
    echo "ftpsave             - uploads file to cs ftp server"
    echo "papers              - wrapper around dropbox paper summaries manager"
    echo "notif               - notifies that process is complete"
    echo "sizes               - lists the size of all folders and files in the current directory"
    echo "gitbook             - alias for using gitbook in docker"
}

#   Android
#   ------------------------------------------------------------
    adbinstallm() {
        if [ "$#" -ne 1 ]; then
            echo "usage: adbinstallm <apk>"
        else
            adb devices | tail -n 3 | head -n 2 | awk '{ print $1 }' | xargs -IX adb -s X install -r $1
        fi
    }

#   App Engine
#   ------------------------------------------------------------
    alias goappd='appcfg.py --oauth2 update .'

#   Flux Printer
#   ------------------------------------------------------------
    alias printer='ssh -N -f -L 9100:155.98.60.195:9100 bas.flux.utah.edu'

#   Google
#   ------------------------------------------------------------
    gdvim() {
        if [ "$#" -ne 1 ]; then
            echo "usage: gdvim <filename>"
        else
            #google docs edit --title $1 --editor vim-html-markdown --format htm --force-auth
            google docs edit $1 --editor vim-html-markdown --format htm
        fi
    }

    vim-html-markdown() {
        file=$1
        markdown=`mktemp .mdown`

        # Convert to markdown with pandocs
        pandoc "$file" -f html -t markdown -o $markdown

        # Edit the markdown file
        vim $markdown

        # And convert it back to html, which can be uploaded to Google Docs
        pandoc $markdown -f markdown -t html -o "$file"

        # clean up
        rm $markdown
    }

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

#   Camera Fix
#   ------------------------------------------------------------
    camera_fix() {
        sudo killall VDCAssistant
        sudo killall AppleCameraAssistant
    }

#   Save to CS FTP
#   ------------------------------------------------------------
    ftpsave() {
        if [ "$#" -ne 1 ]; then
            echo "usage: ftpsave <filename>"
            echo "    *** No paths please, just filename ***"
        else
            FILE=$1
            scp $FILE cs:/home/renquinn/public_ftp/
            echo "File available at ftp://ftp.cs.utah.edu/users/renquinn/$FILE"
        fi
    }

#   Save to CS FTP
#   ------------------------------------------------------------
    papers() {
        usage_string="usage: papers <method>\n    method = new || find"
        if [ "$#" -lt 1 ]; then
            echo -e $usage_string
        else
            method=$1
            if [ "$method" == "new" ]; then
                cd ~/Dropbox/Papers/papers
                python new.py ${@:2}
            elif [ "$method" == "find" ]; then
                cd ~/Dropbox/Papers/papers
                python find.py ${@:2}
            else
                echo -e $usage_string
            fi
        fi
    }

#   Sends notification when terminal process completes
#   ------------------------------------------------------------
    notify() {
        terminal-notifier -title "iTerm2" -message "Process completed!" -sound "default"
    }

#   Displays human-readable size of folders and files in current directory
#   ------------------------------------------------------------
    sizes() {
        ls -l | tail +2 | awk '{$1=$2=$3=$4=$5=$6=$7=$8=""; print $0}' | while read f; do du -hs "$f"; done
    }

#   Run gitbook in docker
#   ------------------------------------------------------------
    alias gitbook='docker run --rm -v "$PWD":/gitbook -p 4000:4000 billryan/gitbook gitbook'

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

    alias gituser='git config user.email "renquinn@gmail.com"'

#   Vim Profiling
#   ------------------------------------------------------------
    alias vimp="vim --startuptime ~/Desktop/vim_startup_report.txt"

#   ---------------------------------------
#   6.  Docker
#   ---------------------------------------

    # Garbage collect old images
    alias docker-clean="docker images -f 'dangling=true' -q | xargs -L1 docker rmi"

    dpython2(){
        if [ "$#" -ne 1 ]
        then
            echo "Usage: dpython2 <script>"
        else
            dpython 2 $1
        fi
    }

    dpython3(){
        if [ "$#" -ne 1 ]
        then
            echo "Usage: dpython3 <script>"
        else
            dpython 3 $1
        fi
    }

    dpython(){
        if [ "$#" -ne 2 ]
        then
            echo "Usage: dpython <version> <script>"
        else
            PWD=`pwd`
            version=$1
            script=$2
            docker run -it --rm \
                --name my-running-script \
                -v "$PWD":/usr/src/myapp \
                -w /usr/src/myapp python:$version \
                python $script
        fi
    }

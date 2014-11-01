# Source this file in bash, ZSH or any sh compatible shell

# See currently opened network connections
alias connections="lsof -P -i -n"

# See external IP
alias myip="curl ifconfig.me"

# Launch PostgreSQL
alias pg="postgres -D /usr/local/var/postgres"

# Launch MySQL
alias mysql="mysql -u root --password="

# less for source code (requires source-highlight package)
srchighlight() {
    echo $1
    src-hilite-lesspipe.sh $1 | less -R
}

alias src=srchighlight
alias sudo="sudo -e"

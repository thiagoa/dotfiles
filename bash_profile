# Seta o prompt
#export PS1="\[\e[0;32m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[m\]\[\e[1;32m\]\`ruby -e \"print (%x{git branch 2> /dev/null}.grep(/^\*/).first || '').gsub(/^\* (.+)$/, '(\1) ')\"\`\$\[\e[m\]\[\e[1;37m\] "
export PS1="\u \w\`ruby -e \"print (%x{git branch 2> /dev/null}.grep(/^\*/).first || '').gsub(/^\* (.+)$/, '(\1) ')\"\`\$ "

print_before_the_prompt () {  
    printf "\n$txtred%s $txtpur%s - $txtred$bldgrn%s $txtpur%s\n$txtrst" "$USER" "$HOSTNAME" "$PWD" "$(vcprompt)"  
}  
      
PROMPT_COMMAND=print_before_the_prompt  
PS1='$ '  

export HISTSIZE=1000

# Seta o environment path
#export PATH=/usr/local/bin:/Applications/MAMP/bin/php5.3/bin:~/Scripts:/opt/local/bin:/opt/local/sbin:$PATH
export PATH=/Applications/MAMP/bin/php5.3/bin:~/Scripts:/opt/local/bin:/opt/local/sbin:$PATH

# Carrega aliases e configurações personalizadas
source ~/.bashrc

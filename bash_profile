# Seta o prompt
export PS1="\u \w\`ruby -e \"print (%x{git branch 2> /dev/null}.grep(/^\*/).first || '').gsub(/^\* (.+)$/, '(\1) ')\"\`\$ "

print_before_the_prompt () {  
    printf "\n$txtred%s $txtpur%s $txtred- $bldgrn%s $txtpur%s\n$txtrst" "$USER" "$HOSTNAME" "$PWD" "$(vcprompt)"  
}  
      
PROMPT_COMMAND=print_before_the_prompt  
PS1='$ '  

export HISTSIZE=1000

# Seta o environment path
export PATH=~/Scripts/mixdev:~/Scripts:/usr/local/bin:/opt/local/bin:/opt/local/sbin:$PATH

# Carrega aliases e configurações personalizadas
source ~/.bashrc

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

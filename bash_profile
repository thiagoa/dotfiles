# Seta o prompt
export PS1="\u \w\`ruby -e \"print (%x{git branch 2> /dev/null}.grep(/^\*/).first || '').gsub(/^\* (.+)$/, '(\1) ')\"\`\⌘ "

print_before_the_prompt () {
    PROMPT=`vcprompt`
    if [[ $PROMPT != "" ]]; then
        PROMPT="($PROMPT)"
    fi
    printf "\n$txtred%s $txtpur%s$txtred $bldgrn%s\n$txtrst" "$USER" "$PWD" "$PROMPT"
}

# alias last and save
# use `als c NAME` to chop off the last argument (for filenames/patterns)
als() {
	local aliasfile chop x
	[[ $# == 0 ]] && echo "Name your alias" && return
	if [[ $1 == "c" ]]; then
		chop=true
		shift
	fi
	aliasfile=~/.dotfiles/custom.aliases.bash
	touch $aliasfile
	if [[ `cat "$aliasfile" |grep "alias ${1// /}="` != "" ]]; then
		echo "Alias ${1// /} already exists"
	else
		x=`history 2 | sed -e '$!{h;d;}' -e x | sed -e 's/.\{7\}//'`
		if [[ $chop == true ]]; then
			echo "Chopping..."
			x=$(echo $x | rev | cut -d " " -f2- | rev)
		fi
		echo -e "\nalias ${1// /}=\"`echo $x|sed -e 's/ *$//'|sed -e 's/\"/\\\\"/g'`\"" >> $aliasfile && source $aliasfile
		alias $1
	fi
}

PROMPT_COMMAND=print_before_the_prompt
PS1='$ '

export HISTSIZE=1000

# Seta o environment path
export PATH=~/Scripts/mixdev:~/Scripts:/usr/local/bin:/opt/local/bin:/opt/local/sbin:$PATH

# Carrega aliases e configurações personalizadas
source ~/.bashrc
source ~/.dotfiles/custom.aliases.bash

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

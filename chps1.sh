source $HOME/git-prompt.sh

PROMPT_COMMAND='PS1_CMD1=$(__git_ps1 " (%s)")';

PS1='\[\e[38;5;114m\]\u\[\e[0m\] at \[\e[38;5;245m\]\h\[\e[0m\] in \[\e[1m\]\w\[\e[0;38;5;202m\]${PS1_CMD1}\[\e[0m\] \$ '

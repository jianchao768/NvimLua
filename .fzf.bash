# Setup fzf
# ---------
if [[ ! "$PATH" == */home/ljc/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/ljc/.fzf/bin"
fi

eval "$(fzf --bash)"

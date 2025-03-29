# === Secure Bash Aliases ===
# Only you should have read/write access to this file
# Run: chmod 600 ~/.bash_aliases

# ----- Basic Shortcuts -----
alias cls='clear'
alias ll='ls -lah --color=auto'
alias gs='git status'
alias update='sudo apt update && sudo apt upgrade -y'

# ----- Safer Commands -----
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# ----- Navigation -----
alias ..='cd ..'
alias ...='cd ../..'
alias home='cd ~'
alias config='nano ~/.bashrc && source ~/.bashrc'

# ----- SSH Management -----
alias fixssh='chmod 700 ~/.ssh && chmod 600 ~/.ssh/id_* && chmod 644 ~/.ssh/*.pub'

# ----- Custom Function: Fix Ownership -----
own() {
  for target in "$@"; do
    if [ ! -e "$target" ]; then
      echo "❌ File not found: $target"
      continue
    fi

    owner=$(stat -c "%U:%G" "$target")
    if [ "$owner" = "$USER:$USER" ]; then
      echo "✔️ Already owned: $target"
    else
      echo "🔧 Changing ownership: $target"
      sudo chown "$USER:$USER" "$target"
    fi

    # Fix SSH file permissions
    if [[ "$target" == *".ssh/"* || "$target" == *"id_"* ]]; then
      echo "🔒 Fixing SSH permissions for: $target"
      [[ "$target" == *.pub ]] && chmod 644 "$target" || chmod 600 "$target"
    fi
  done
}

# ----- Reload Aliases Easily -----
alias reload='source ~/.bash_aliases && echo "✅ Aliases reloaded"'

# End of .bash_aliases


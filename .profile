export PATH="$HOME/bin:/usr/local/bin:/usr/local/homebrew/bin:/usr/local/opt/postgresql@17/bin:/usr/bin:/bin:/usr/sbin:/usr/local/sbin:/sbin:/usr/X11/bin"

[[ -s "$HOME/.git-completion.sh" ]] && . "$HOME/.git-completion.sh" 

export PS1='\[\033[01;34m\][\W$(__git_ps1 "(%s)")]\[\033[00m\] \$ '
export PS2="> "

cdfunction() {
  if [ "$PWD" != "$MYOLDPWD" ]; then
    MYOLDPWD="$PWD"
    for ss in devsetup venv/bin/activate .venv/bin/activate; do
      if [ -f ./$ss ]; then
        source ./$ss
      fi
    done
  fi
}

gdsspw() {
  echo "jdK3+o3m" | pbcopy
}

# Homebrew
export HOMEBREW_NO_INSTALLED_DEPENDENTS_CHECK=1

export PROMPT_COMMAND=cdfunction

export DYLD_LIBRARY_PATH=/usr/local/opt/openssl/lib:$DYLD_LIBRARY_PATH

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/ech/google-cloud-sdk/path.bash.inc' ]; then . '/Users/ech/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/ech/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/ech/google-cloud-sdk/completion.bash.inc'; fi

# pyenv
export PATH="/Users/ech/.pyenv/shims:${PATH}"
export PYENV_SHELL=bash
source '/usr/local/Cellar/pyenv/2.5.2/libexec/../completions/pyenv.bash'
command pyenv rehash 2>/dev/null
pyenv() {
  local command
  command="${1:-}"
  if [ "$#" -gt 0 ]; then
    shift
  fi

  case "$command" in
  rehash|shell)
    eval "$(pyenv "sh-$command" "$@")";;
  *)
    command pyenv "$command" "$@";;
  esac
}

export PATH="${PATH}:./node_modules/.bin"


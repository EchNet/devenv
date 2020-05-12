LOCAL_PATH="$HOME/bin:/usr/local/bin:/usr/local/mysql/bin"
export PATH="$LOCAL_PATH:/usr/bin:/bin:/usr/sbin:/usr/local/sbin:/sbin:/usr/X11/bin"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
[[ -s "$HOME/.git-completion.sh" ]] && . "$HOME/.git-completion.sh" 

export PS1='\[\033[01;34m\][\W$(__git_ps1 "(%s)")]\[\033[00m\] \$ '
export PS2="> "

# EC2 stuff.
export PRIMUS_KEY=/Users/Ech/.ec2/echkeykey.pem
export PRIMUS=ec2-user@ec2-50-17-71-241.compute-1.amazonaws.com
alias primus="ssh -i $PRIMUS_KEY $PRIMUS"

cdfunction() {
  if [ "$PWD" != "$MYOLDPWD" ]; then
    MYOLDPWD="$PWD"
    for ss in devsetup env/bin/activate; do
      if [ -f ./$ss ]; then
        source ./$ss
      fi
    done
  fi
}

export PROMPT_COMMAND=cdfunction

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

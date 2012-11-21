LOCAL_PATH="$HOME/dev/wf/bin:$HOME/local/bin:$HOME/local/mongodb/bin:/usr/local/bin:/usr/local/mysql/bin"
export PATH="$LOCAL_PATH:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin"
export NODE_PATH="$HOME/local/node:$HOME/local/node/lib/node_modules"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
[[ -s "$HOME/.git-completion.sh" ]] && . "$HOME/.git-completion.sh" 

# export PS1="\[\e]0;\u@\h: \w\a\]\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\$ "
export PS1='[\u@\h:\W$(__git_ps1 "(%s)")]\$ '
export PS2="> "

# EC2 stuff.
export PRIMUS_KEY=/Users/Ech/.ec2/echkeykey.pem
export ARDRONE_KEY=/Users/Ech/.ec2/ardrone.pem
export CI_KEY=/Users/Ech/.ec2/ubuntu.pem

export PRIMUS=ec2-user@ec2-50-17-71-241.compute-1.amazonaws.com
export ARDRONE1=ec2-user@ardrone-1.swoop.com
export DEEPSPACE=ec2-user@deep-space.swoop.com
export ARDRONE2=ec2-user@ardrone-2.swoop.com
export ARDRONE3=ec2-user@10.88.0.111
export SHOTGUN=ec2-user@ec2-75-101-191-1.compute-1.amazonaws.com
export HOBO=ec2-user@10.88.0.99
export VULCAN=ec2-user@vulcan.swoop.com
export CI=ubuntu@ec2-107-20-143-106.compute-1.amazonaws.com
export SPX_DEV_ROOT=~/dev

alias primus="ssh -i $PRIMUS_KEY $PRIMUS"
alias ardrone1="ssh -i $ARDRONE_KEY $ARDRONE1"
alias ardrone2="ssh -i $ARDRONE_KEY $ARDRONE2"
alias ardrone3="ssh -i $ARDRONE_KEY $ARDRONE3"
alias deepspace="ssh -i $ARDRONE_KEY $DEEPSPACE"
alias shotgun="ssh -i $ARDRONE_KEY $SHOTGUN"
alias hobo="ssh -i $ARDRONE_KEY $HOBO"
alias ci="ssh -i $CI_KEY $CI"
alias vulcan="ssh -i $ARDRONE_KEY $VULCAN"

alias bc="build clean cobertura:cobertura"
alias words="pushd ~/8svn/dev/modules/anagram/words/src"

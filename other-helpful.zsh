#!/usr/bin/env zsh
#
#
function catwh() {
  cat `which $1`
}

function archsInFile() { lipo  -archs $1 }


# Alternative to skip first line is:  tail -n +2
function ignoreFirstLine() { awk 'NR != 1'  }
alias allButFirstLine=ignoreFirstLine
alias skipFirstLine=ignoreFirstLine

function ignoreLastLine() { awk -v n=1 '{if(NR>n) print a[NR%n]; a[NR%n]=$0}' }
alias allButLastLine=ignoreLastLine
alias skipLastLine=ignoreLastLine
# Ignore last 2 lines: awk -v n=2 '{if(NR>n) print a[NR%n]; a[NR%n]=$0}'


function printFileSkippingLine() {
  cat $1 | awk "{if (NR!=$2) print}"
}
function rmKnownHostLn() { printFileSkippingLine /Users/bbarrows/.ssh/known_hosts $1 > /Users/bbarrows/.ssh/known_hosts }
alias sshRMKnownHost=rmKnownHostLn

function cwjustdir() { pwd | awk -F'/' '{print $NF}' }
alias pwdJustLastDir=cwjustdir
alias justThisDir=cwjustdir

function lslist() {
  zle -U "sudo lsof -n -i \":$1\" | grep LISTEN"
}
zle -N lslist


function lsListeningOnPort() {
  echo sudo lsof -n -i ":$1" | grep LISTEN
  sudo lsof -n -i ":$1" | grep LISTEN
}


function listShellColors() {
  for x in {0..8}; do for i in {30..37}; do for a in {40..47}; do echo -ne "\e[$x;$i;$a""m\\\e[$x;$i;$a""m\e[0;37;40m "; done; echo; done; done; echo ""
}

function listShellColorsByNumber() {
  for i in {0..255} ; do
    printf "\x1b[48;5;%sm%3d\e[0m " "$i" "$i"
    if (( i == 15 )) || (( i > 15 )) && (( (i-15) % 6 == 0 )); then
        printf "\n";
    fi
done
}

function promptForYesNo() {
  # After calling this function check for yes or no with:
  # if [ "$YESNOPROMPT" = "YES" ]; then echo "its a yes"; fi
  # if [ "$YESNOPROMPT" = "NO" ]; then echo "its a no"; fi
  if read -q "choice?Enter y/n: "; then
      export YESNOPROMPT="YES"
  else
      export YESNOPROMPT="NO"
  fi
  echo "\n"
  }


function fwhich() {
ls -al $(which $1)
}


#### If you have hub installed:
#
function setUpstreamOrigin() {
  local gitfs
  gitfs=$(gr -v | grep origin | awk '{if(NR==1) print $2}')

  local reponamedefault
  local reponame
  reponamedefault=$(pwd | awk -F'/' '{print $NF}')
  reponame=${1:-reponamedefault}

  local hubflag
  hubflag=""
  [ "$#" -eq 2 ] && hubflag="-p"
  [[ "$1" == "-p" ]] && hubflag="-p"
  [[ "$1" == "-p" ]] && reponame=$reponamedefault

  # this line prob inst necessary
  [ "$#" -eq 1 ] && [[ "$1" == "-p" ]] && hubflag="-p"  && reponame=$reponamedefault

  [ "$#" -eq 0 ] && hubflag=""  && reponame=$reponamedefault


  echo """
  gr rm origin
  gr add upstream $gitfs
  hub create $reponame $hubflag
  """
  gr rm origin
  gr add upstream $gitfs
  hub create $reponame $hubflag

}

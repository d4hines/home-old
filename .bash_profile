#!bin/bash

complainEmpty() {
  echo "No value detected for variable $1. Please set and restart the shell before continuing."
}

[ -z "$CORE" ] && complainEmpty "CORE"
[ -z "$SEED" ] && complainEmpty "SEED"
[ -z "$FEA" ] && complainEmpty "FEA"
[ -z "$DLL" ] && complainEmpty "DLL"
[ -z "$PATCHES" ] && complainEmpty "PATCHES"

alias msbuild="/c/Program\ Files\ \(x86\)/Microsoft\ Visual\ Studio/2019/Community/MSBuild/Current/Bin/amd64/MSBuild.exe"
alias core='cd $CORE && npm run build'
alias seed='cd $SEED && npm run dev'
alias fea='cd $FEA && npm run dev'
alias load_profile='source ~/.bash_profile'

dll() {
  if [ "$1" == "r" ]
  then
    msbuild $DLL //p:Configuration=Release
  else
    msbuild $DLL //p:Configuration=Debug
  fi
}

up() {
  rm -f "$CORE/dist/index.js"
  core &
  fea &
  echo "Waiting for Core to finish..."
  while [[ ! -f "$CORE/dist/index.js" ]]
  do
    sleep 1
  done
  echo "Core is done!"
  seed
}

_project_sha() {
  cd $CORE
  local core_sha=$(git rev-parse HEAD)
  cd $SEED
  local seed_sha=$(git rev-parse HEAD)
  cd $FEA
  local fea_sha=$(git rev-parse HEAD)

  local output="Core: $core_sha\nSeed: $seed_sha\nFEA: $fea_sha"
  echo -e $output
  echo -e $output | clip
}

all=($SEED $CORE $FEA)

_add() {
  case $1 in
    "wpf")
      cd "$SEED"
      git apply "$PATCHES"/WPFExample.diff
      ;;
    "console")
      cd "$CORE"
      git apply "$PATCHES"/show-console.diff
      ;;
    "of")
      cd "$SEED"
      git apply "$PATCHES"/openfin.diff
      ;;
    *)
      echo "Usage: $0 {wpf}"
      echo "Applies various patches to finsemble"
      ;;
  esac
}

_checkoutAndVerify() {
  cd $1
  git checkout $2
}

_wipe() {
  cd $1
  rm -rf node_modules
  set GIT_ASK_YESNO=false
  git clean -xfd
  npm i
  npm link
}

_clear_cache() {
  rm -rf $APPDATA/Openfin
  rm -rf $APPDATA/e2o
  rm -rf $APPDATA/finsemble-electron-adapter
  rm -rf $LOCALAPPDATA/Openfin
}

fsbl() {
  case $1 in
     "sha")
        _project_sha
        ;;
      "add")
        _add $2
        ;;
      "co")
        for x in "${all[@]}"
        do
          _checkoutAndVerify $x $2 &
        done
        wait
        ;;
      "wipe")
        for x in "${all[@]}"
        do
          _wipe $x &
        done
        wait
        cd $SEED
        npm link @chartiq/finsemble @chartiq/finsemble-electron-adapter
        ;;
     *)
        echo "Usage: $0 {sha|co}"
        echo "sha: Prints the git SHA's of Core, Seed, and FEA"
        ;;
  esac
}

alias f='fsbl'

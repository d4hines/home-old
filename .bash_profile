#!bin/bash

export PATH=$PATH:"~/bin"

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
alias seed='cd $SEED && npm run dev:fresh'
alias fea='cd $FEA && npm run dev'
alias load_profile='source ~/.bash_profile'

dll() {
  if grep -Pq '(Release.*Debug)|(Debug.*Release)' "$DLL/FinsembleDotNet.sln"
  then
    echo "Someone screwed up the build configuration! There are either Release builds in the Debug mode or Debug builds in the Release mode."
  elif [ "$1" == "r" ]
    then
      msbuild $DLL //p:Configuration=Release
      echo "Finsemble-DLL built in release mode!"
  else
    msbuild $DLL //p:Configuration=Debug
    echo "Finsemble-DLL built in debug mode!"
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
      git apply --ignore-space-change --ignore-whitespace --3way "$PATCHES"/WPFExample.diff
      ;;
    "console")
      cd "$CORE"
      git apply "$PATCHES"/show-console.diff
      ;;
    "tab33")
      cd "$SEED"
      rm -rf ./src/components/groupUpdateTest
      git apply "$PATCHES"/tab33.diff
      ;;
    "tab34")
      cd "$SEED"
      git apply "$PATCHES"/tab33.diff
      ;;
    "of")
      cd "$SEED"
      git apply "$PATCHES"/openfin.diff
      ;;
    "java")
      cd "$SEED"
      git apply "$PATCHES"/java.diff
      cp "$REPOS"/finsemble-java-example/java-example.json "$SEED"/configs
      ;;
    "appd")
      cd "$SEED"
      git apply "$PATCHES"/appd-server.diff
      ;;
    *)
      echo "Usage: $0 {wpf}"
      echo "Applies various patches to finsemble"
      ;;
  esac
}

_checkoutAndVerify() {
  cd $1
  git checkout package.json
  git checkout $2
  git fetch
  git pull
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
  rm -rf $APPDATA/e2o
  rm -rf $APPDATA/finsemble-electron-adapter
  rm -rf $APPDATA/Electron
  rm -rf $APPDATA/Openfin
  rm -rf $LOCALAPPDATA/Openfin
}

fsbl() {
  case $1 in
     "clear")
        _clear_cache
        ;;
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
        _clear_cache
        ;;
      "kill")
        finsemble-cli kill
        ;;
      "install")
        for x in "${all[@]}"
        do
          npm i && npm link &
        done
        wait
        npm link @chartiq/finsemble @chartiq/finsemble-electron-adapter
        ;;
     *)
        echo "Usage: $0 {sha|co|clear|add|wipe|kill|install}"
        echo "sha: Prints the git SHA's of Core, Seed, and FEA"
        echo "co {git branch}: Checks out the branch on Core, Seed, and FEA"
        echo "clear: Clears the cache (in APPDATA and LOCALAPPDATA)"
        echo "add {wpf|console|tab33|tab34|of|java|appd}: Applies a git patch to add the specified setup"
        echo "wipe: Reverts Core, Seed, and FEA repositories to their clean state, then installs there dependencies and links them."
        echo "kill: Alias for finemble-cli kill"
        echo "install: Installs dependencies and links for Core, Seed, and FEA"
        ;;
  esac
}

alias f='fsbl'

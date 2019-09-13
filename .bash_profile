CORE=~/repos/finsemble
SEED=~/repos/finsemble-seed
FEA=~/repos/finsemble-electron-adapter
DLL=~/repos/finsemble-dll
PATCHES=~/fsbl-patches

alias msbuild="/c/Program Files \(x86\)/Microsoft Visual Studio/2019/Community/MSBuild/Current/Bin/amd64/MSBuild.exe"
alias core='cd $CORE && npm run build'
alias seed='cd $SEED && npm run dev'
alias fea='cd $FEA && npm run dev'
alias dll='msbuild'
alias load_profile='source ~/.bash_profile'

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

project_sha() {
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

add() {
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

fsbl() {
  case $1 in
     "sha")
        project_sha
        ;;
      "co")
        for x in "${all[@]}"
        do
          cd $x
          git checkout $2
        done
        ;;
     *)
        echo "Usage: $0 {sha|co}"
        echo "sha: Prints the git SHA's of Core, Seed, and FEA"
        ;;
  esac
}

alias f='fsbl'

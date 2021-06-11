
# install choco
if (!(Get-Command choco -ErrorAction SilentlyContinue)) {
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

choco install -y vscode brave slack f.lux autohotkey signal greenshot zoom


if (!(Get-Command git -ErrorAction SilentlyContinue)) {
    Msg $env:USERNAME "Install Git before running this script"
    throw "Install Git before running this script"
}

if (!(Test-Path C:\Users\d4hin\.homegit)) {
    git clone https://github.com/d4hines/home $home/home
    gci $home/home -Force -Recurse | Move-Item -Destination $home
    rm $home/home -ErrorAction SilentlyContinue -Recurse

    Move-Item $home/.git $home/.homegit -ErrorAction SilentlyContinue 

    function set-shortcut {
        param ( [string]$SourceLnk, [string]$DestinationPath )
        $WshShell = New-Object -comObject WScript.Shell
        $Shortcut = $WshShell.CreateShortcut($SourceLnk)
        $Shortcut.TargetPath = $DestinationPath
        $Shortcut.Save()
    }

    set-shortcut "$home\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\profile.ahk.lnk" "$home\profile.ahk"
}

# WSL2 set up
choco install -y wsl2

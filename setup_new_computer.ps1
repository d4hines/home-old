# Run this command first.
Set-ExecutionPolicy Bypass -Scope Process -Force;

if (!(Get-Command choco -ErrorAction SilentlyContinue)) {
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

choco install -y vscode brave protonvpn ferdi spotify audacity f.lux autohotkey docker-desktop signal greenshot zoom


if (!(Get-Command git -ErrorAction SilentlyContinue)) {
    Msg $env:USERNAME "Install Git before running this script"
    throw "Install Git before running this script"
}

if (!(Test-Path C:\Users\d4hin\.git)) {
    git clone https://github.com/d4hines/home $home/home

    gci $home/home -Force | Move-Item -Destination $home
    rm $home/home
    function set-shortcut {
        param ( [string]$SourceLnk, [string]$DestinationPath )
        $WshShell = New-Object -comObject WScript.Shell
        $Shortcut = $WshShell.CreateShortcut($SourceLnk)
        $Shortcut.TargetPath = $DestinationPath
        $Shortcut.Save()
    }

    set-shortcut "$home\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\profile.ahk.lnk" "$home\profile.ahk"
}

# Install scoop
if (!(Get-Command scoop -ErrorAction SilentlyContinue)) {
  Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
}


scoop install git 

scoop bucket add extras

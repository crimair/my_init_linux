# prepare wsl

```
wsl --set-default-version 2
wsl --list --verbose
wsl --list --online
wsl --install --distribution <distribution name>
wsl --set-version <distribution name> <versionNumber>
wsl --shutdown
wsl --terminate <Distribution Name>
```

ttps://ktkr3d.github.io/2020/07/06/USB-support-to-WSL2/

```
fcitx-configtool
```

```
all-the-icons-install-fonts
```

chocolatey
```
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

```
choco install neovim --pre
```

emacsのキー配列が変な場合
```
setxkbmap -layout jp
```

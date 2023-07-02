# Dotfiles

Hey! After a lot of rambling, I'll be posting dotfiles of my dear **Arch Linux** setup, my main tasks using this environment are **programming** and **cybersecurity** work, so you'll probably see some weird configs that will be geared towards that.

I ask that those who want to use most of the settings, to **fork this repository** so that I can see your additional settings and maybe add them to my setup too, I'm always implementing it, in advance, **thanks!**

_WIP: I will be working on a script to install my dotfiles automatically, after a clean install of Arch Linux._

### My Setup
**Distro:** [Arch Linux](https://archlinux.org/download/) \
**WM:** [Qtile](https://github.com/qtile/qtile) \
**Compositor:** [Picom (fdev31)](https://github.com/fdev31/picom) \
**Notifications:** [Dunst](https://github.com/dunst-project/dunst) \
**Shell:** [Fish](https://fishshell.com/) \
**Terminal:** [Alacritty](https://github.com/alacritty/alacritty) \
**Editor:** [NvChad](https://github.com/NvChad/NvChad) \
**Multiplexer:** [Tmux](https://github.com/tmux/tmux/) \
**App Launcher:** [Rofi](https://github.com/davatorium/rofi)

<br>

<details>
  <summary><b>BONUS:</b> Installing Bocchi Cursors</summary>
  </br>
  
  > Using GTK tweak tool

  - Install the .zip file called "**Bocchi-Linux**" from Kofi [here](https://ko-fi.com/s/6ba0d6b935)
  - Unzip the downloaded file and rename the folder to "_bocchi-cursors_"
  - Move entire folder to `/usr/share/icons`
  - Use [lxappearance](https://github.com/lxde/lxappearance) to select cursor theme, and **done!**

  > Without LXAppearance

  - After renaming and moving the folder to `/usr/share/icons` you can create/change the `~/.icons/default/index.theme` file like this:
  ```ini
  [Icon Theme]
  Name=Default
  Comment=Default Cursor Theme
  Inherits=bocchi-cursors
  ```
  and `~/.config/gtk-*/settings.ini`:
  ```ini
  [Settings]
  gtk-cursor-theme-name=bocchi-cursors
  ```
  **Done!**
</details>

### Demo

![](./showcase/screenshot01.png)

<img src="https://user-images.githubusercontent.com/123886904/218294072-d474a330-7464-430a-b369-91f79373dbca.svg" width="100%" title="Footer">

# Toolbox

A collection of my bash scripts, systemd services, and other utilities I use on my Linux system.

## GNOME Extensions

The `/gnome/extension_settings.dconf` file contains settings for my GNOME extensions.
To import them, run:

```bash
dconf load /org/gnome/shell/extensions/ < ~/toolbox/gnome/extension_settings.dconf
```

## Shortcuts

In `/gnome/shortcuts.dconf` there are some custom shortcuts. Including:

- swithing workspaces via `super` + `[num]` keys,
- moving windows to other workspaces via `shift` + `super` + `[num]` keys
- launch nautilus with `super` + `f` key
- launch browser with `super` + `b` key
- mute mic with `F9` key
- launch ptyxis (terminal) with `super` + `t` key
- launch system monitor (btop) with `shift` + `control` + `escape` key

Also i have music media controls bound to my knob on keyboard that lets me change spotify/youtube music volume, play/pause music and skip to next song.

To load them, run:

```bash
dconf load /org/gnome/desktop/wm/keybindings/ < <(sed -n '/\[org\/gnome\/desktop\/wm\/keybindings\]/,/^$/p' ~/toolbox/gnome/shortcuts.dconf)
dconf load /org/gnome/settings-daemon/plugins/media-keys/ < <(sed -n '/\[org\/gnome\/settings-daemon\/plugins\/media-keys\]/,/^$/p' ~/toolbox/gnome/shortcuts.dconf)
```

## Scripts

In `/bin` folder you can find my collection of bash scripts.

There is folder `music-volume-control` that contains scripts for controlling music volume and playback.

And also `fix-razer-audio.sh` that I run via systemd service every GNOME Shell login to fix some weird audio issue with my headphones (Razer Barracuda X). The only real fix that community found over the years is to change audio output to whatever else and back again to Barracudas output (same thing happens also on Windows and MacOS).

## Systemd services

`/systemd` folder contains my systemd services.

- `disable-ram-rgb.service` - turns off RGB on my Kingston Fury Renegade RGB ram, haven't found any solution to turn it off permanently, need to run it every system boot. It uses some [rust utility](https://github.com/aritz-cracker/fury-renegade-rgb) I found on GitHub. OpenRGB still doesn't support these specific modules.
- `turn-off-display.service` - turns off my display on system shutdown.
- `fix-razer-audio.service` - runs the `fix-razer-audio.sh` script after GNOME Shell login to fix audio output for my headphones.

To register them run:

```bash
# system-level services (requires sudo)
sudo ln -s ~/toolbox/systemd/system/disable-ram-rgb.service /etc/systemd/system/disable-ram-rgb.service
sudo ln -s ~/toolbox/systemd/system/turn-off-display.service /etc/systemd/system/turn-off-display.service

sudo systemctl daemon-reload
sudo systemctl enable disable-ram-rgb.service
sudo systemctl enable turn-off-display.service

# user-space service
mkdir -p ~/.config/systemd/user/
ln -s ~/toolbox/systemd/user/fix-razer-audio.service ~/.config/systemd/user/fix-razer-audio.service

systemctl --user daemon-reload
systemctl --user enable fix-razer-audio.service
```

## Udev rules

`50-i2c.rules` - allows i2c writes for the fury renegade ram script.
`50-nuphy.rules` - allows updating my Nuphy Air75 v3 keyboard firmware.
`90-usb-wakeup.rules` - allows my usb devices to wake up the system.

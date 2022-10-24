# VSCode Project Manager

Launcher and Project Manager for Visual Studio Code

![image](https://raw.githubusercontent.com/basson/vscode-pm/main/data/screenshots/vscode-pm-screenshot.png)

## Dependencies

* gtk+-3.0>=3.22.29
* granite>=5.2
* glib-2.0
* gee-0.8
* gobject-2.0
* libxml-2.0
* meson

## Building
```
meson build --prefix=/usr
sudo ninja -C build install
```

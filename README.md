# share-lan

Simple HTTP file server for LAN sharing, packaged as a Debian `.deb`.
All files are served with `Content-Disposition: attachment`, so clicking
a link triggers a download instead of opening in the browser.

## Features

- Serves a directory over HTTP on all interfaces (`0.0.0.0`)
- Force-download for every file (no in-browser preview)
- Systemd service — auto-starts on boot
- Configurable via `/etc/share-lan.conf`
- Tiny package (~2 KB), depends only on `python3`

## Install

Download the `.deb` from [Releases](../../releases) (or build it yourself, see below), then:

```bash
sudo dpkg -i share-lan_1.0_all.deb
```

The service starts automatically. Check status:

```bash
systemctl status share-lan
```

Example output:

```
● share-lan.service - share-lan HTTP file server (force download)
     Loaded: loaded (/usr/lib/systemd/system/share-lan.service; enabled; preset: enabled)
     Active: active (running) since Wed 2026-04-22 09:32:58 +07; 12min ago
   Main PID: 78659 (python3)
      Tasks: 1 (limit: 38214)
     Memory: 9.3M (peak: 9.6M)
        CPU: 90ms
     CGroup: /system.slice/share-lan.service
             └─78659 python3 /usr/bin/share-lan
```

## Usage

From any device on the LAN, open:

```
http://<server-ip>:8765/
```

Click any file → downloads immediately.

## Configuration

Edit `/etc/share-lan.conf`:

```ini
PORT=8765
DIRECTORY=/home/neil/shared
RUN_AS_USER=neil
```

Then restart:

```bash
sudo systemctl restart share-lan
```

## Build from source

```bash
git clone git@github.com:chuccv/share-lan.git
cd share-lan
./build.sh
sudo dpkg -i share-lan_1.0_all.deb
```

Requires: `dpkg-deb`, `fakeroot`, `python3`.

## Uninstall

```bash
sudo apt remove share-lan      # keep config
sudo apt purge share-lan       # remove config too
```

## License

MIT

# blockmusic 🚫🎵

A minimalist, zero-dependency, 0% CPU background daemon for macOS that kills Apple Music (and iTunes) on startup, and stops it from automatically relaunching when you press media controls (e.g. on Bluetooth headphones, keyboard media keys, etc.).

## 🪓 The Simplest Fix?

If you're a minimalist at heart, the bare minimum might be all you need:

```sh
while true; do pkill -9 -x Music -x iTunes 2>/dev/null; sleep 1; done
```

This works, but it polls every second, and it won't survive a terminal close.

If you want something more polished, efficient, and feature-rich — menu bar toggle, media key redirect, Homebrew install — check out [`noTunes`](https://github.com/tombonez/noTunes), the project that inspired `blockmusic`.

But if you're like me and want something in-between — no config, out of sight, and above all, code short and clear enough to review and understand, and quick and easy to vet — read on.

## ✨ Why `blockmusic`?

- 🎯 **Dead Simple:** [24 lines of Swift](https://github.com/kevduc/blockmusic/blob/main/blockmusic.swift) (including 4 helpful comments). No UI, no config, no deps, no bloat — good defaults, does one thing and does it well.
- 🔍 **Fully Auditable:** Review the entire codebase in under a minute.
- ⚡ **Zero Overhead:** Event-driven with native macOS APIs, 0% CPU while idle.
- 🧘 **No SIP Disabling:** Works on modern macOS without bypassing System Integrity Protection.
- 🧩 **Native Integration:** Runs as a LaunchAgent daemon, installed cleanly in `~/Library/`, following macOS conventions.
- 💻 **Universal Binary:** Runs natively on both Apple Silicon and Intel Macs.

## 🚀 Installation

Run the following command in your Terminal to automatically download and install `blockmusic` ([view script](https://github.com/kevduc/blockmusic/blob/main/install.sh)):

```sh
curl -sfSL https://raw.githubusercontent.com/kevduc/blockmusic/main/install.sh | sh
```

### From source

A local install script is provided if you'd rather audit and build the code yourself ([view script](https://github.com/kevduc/blockmusic/blob/main/install-local.sh)):

```sh
git clone https://github.com/kevduc/blockmusic.git
cd blockmusic
./install-local.sh
```

## 🧹 Uninstallation

([view script](https://github.com/kevduc/blockmusic/blob/main/uninstall.sh))

```sh
curl -sfSL https://raw.githubusercontent.com/kevduc/blockmusic/main/uninstall.sh | sh
```

### From source

If you cloned the repo locally:

```sh
./uninstall.sh
```

## 🔧 Without Installing

It all boils down to a single binary. Build it yourself

```sh
swiftc blockmusic.swift -o blockmusic
```

or grab it from the [latest release](https://github.com/kevduc/blockmusic/releases/latest), then just run it:

```sh
./blockmusic
```

Note: this runs in the foreground and stops when you close the terminal. For a persistent background daemon, look at the [installation](#-installation) method above.

## 💡 Acknowledgements

Inspired by [`noTunes`](https://github.com/tombonez/noTunes) by [Tom Bonez](https://github.com/tombonez).

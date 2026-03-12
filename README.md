# nichs-os

A declarative, reproducible NixOS system configuration managed with [Home Manager](https://github.com/nix-community/home-manager).

---

## Table of Contents

- [Overview](#overview)
- [Repository Structure](#repository-structure)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Configuration](#configuration)
  - [System (`configuration.nix`)](#system-configurationnix)
  - [Home (`home.nix`)](#home-homenix)
- [Packages & Programs](#packages--programs)
- [Customisation](#customisation)
- [Contributing](#contributing)

---

## Overview

**nichs-os** is a personal NixOS setup that keeps the entire machine — from boot loader to shell theme — in version-controlled, reproducible Nix files.  
Declarative configuration means a fresh install can be reproduced exactly by copying these files and running a single command.

| Property | Value |
|---|---|
| NixOS version | 25.05 |
| Home Manager channel | `release-25.11` |
| Hostname | `nichsOS` |
| Timezone | `Europe/Berlin` |
| Locale | `en_GB.UTF-8` (date/time/units: `de_DE`) |
| Desktop | GNOME (Wayland via GDM) |
| Shell | Zsh + Oh My Zsh |

---

## Repository Structure

```
nichs-os/
├── configuration.nix   # NixOS system-level configuration
└── home.nix            # Home Manager user configuration (korbi)
```

> `hardware-configuration.nix` is machine-specific and **not** tracked here.  
> Generate it on the target machine with `nixos-generate-config`.

---

## Prerequisites

- A machine with [NixOS](https://nixos.org/) installed (version ≥ 25.05 recommended)
- Internet access (Home Manager is fetched at build time)

---

## Installation

1. **Clone** this repository:

   ```bash
   git clone https://github.com/KorbiSieber/nichs-os.git
   ```

2. **Generate** hardware configuration for your machine (if not already done):

   ```bash
   sudo nixos-generate-config --show-hardware-config > /etc/nixos/hardware-configuration.nix
   ```

3. **Copy** the system configuration:

   ```bash
   sudo cp configuration.nix /etc/nixos/configuration.nix
   ```

4. **Copy** the home configuration:

   ```bash
   mkdir -p /home/korbi/.config/nixpkgs
   cp home.nix /home/korbi/.config/nixpkgs/home.nix
   ```

5. **Rebuild** the system:

   ```bash
   sudo nixos-rebuild switch
   ```

---

## Configuration

### System (`configuration.nix`)

| Section | Details |
|---|---|
| Boot loader | GRUB, OS-Prober enabled, device `/dev/sda` |
| Networking | NetworkManager |
| Audio | PipeWire (PulseAudio compat, ALSA 32-bit) |
| Virtualisation | Podman with `docker` alias & DNS |
| Dynamic linking | `nix-ld` enabled (required for `uv`) |
| Unfree packages | Allowed |

### Home (`home.nix`)

| Section | Details |
|---|---|
| Shell | Zsh, Oh My Zsh (`robbyrussell` theme), autosuggestions, syntax highlighting |
| Terminal | Kitty — JetBrains Mono 13 pt, Adapta Nokto Maia theme, blur/transparency |
| Editor | VSCodium — Python, Ruff, Git Graph, Git Blame, Jupyter extensions |
| Fetch tool | fastfetch with a Monet painting as logo (kitty graphics) |

---

## Packages & Programs

### System-wide (`environment.systemPackages`)

| Package | Purpose |
|---|---|
| `git` | Version control |
| `vim` | Terminal editor |
| `curl` / `wget` | HTTP clients |
| `firefox` | Web browser |
| `jq` | JSON processor |
| `kitty` | GPU-accelerated terminal |
| `docker-compose` | Compose files for Podman |
| `uv` | Fast Python package manager |
| `vscodium` | Open-source VS Code build |

### User packages (`home.packages`)

| Package | Purpose |
|---|---|
| `fastfetch` | System info display on shell start |

---

## Customisation

- **Change timezone/locale** — edit `time.timeZone` and `i18n.*` in `configuration.nix`.
- **Add system packages** — append to `environment.systemPackages` in `configuration.nix`.
- **Add user packages** — append to `home.packages` in `home.nix`.
- **Change shell theme** — update `oh-my-zsh.theme` in `home.nix`.
- **Add VSCodium extensions** — add entries to `profiles.default.extensions` in `home.nix`.
- **Switch boot device** — update `boot.loader.grub.device` in `configuration.nix`.

After any change, apply it with:

```bash
sudo nixos-rebuild switch
```

---

## Contributing

1. Fork the repository and create a feature branch.
2. Make your changes to `configuration.nix` or `home.nix`.
3. Test on a NixOS machine or VM with `sudo nixos-rebuild test`.
4. Open a pull request describing what you changed and why.

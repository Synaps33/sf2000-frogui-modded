# FrogUI - Modded Fork (SF2000 & GB300)

Custom firmware UI & Menu for **Data Frog SF2000** and **GB300** retro handheld consoles.
Forked from [angree/sf2000-frogui-modded](https://github.com/angree/sf2000-frogui-modded).

---

## ✨ Features

- **XMB Waves Generator**: Dynamic animated background wave (PS3/PSP style) using fast precomputed LUT for 60 FPS without FPU lag. Fully customizable via UI settings and `theme.ini` (Color/HEX, Glow intensity, Single/Dual/Complex variety).
- **Icons & Thumbnails**:
  - Game icons: `<game>-icon.png` (with full RGBA565 alpha transparency) or `<game>-icon.rgb565`.
  - Game covers / thumbnails: `<game>.png`, `.webp`, `.jpg`, `.bmp`, `.gif` directly in ROM folders or `.res/` folders.
- **Theme Engine (`theme.ini`)**:
  - Vertical list or horizontal Nintendo Switch-style carousel layout.
  - Per-platform backgrounds, icons, logos, and custom color palettes.
- **Built-in Apps**:
  - Total Commander-style dual-panel File Manager.
  - Music Player with background playback support.
  - Image and Video Player.
  - Text File Viewer & Editor (with On-Screen Keyboard).
  - 15-decimal precision Calculator.

---

## 🛠️ Requirements & Toolchain Setup (Building on a new PC)

To build FrogUI on a new computer (Windows via WSL, or native Linux Ubuntu/Debian):

### 1. Install prerequisites in Linux / WSL
```bash
sudo apt update
sudo apt install -y build-essential gcc g++ make git wget tar
```

### 2. Install MIPS Toolchain
The multicore framework requires the MIPS toolchain installed at `/opt/mips32-mti-elf/2019.09-03-2/`.

Run the following commands in Linux / WSL:
```bash
sudo mkdir -p /opt/mips32-mti-elf
cd /opt/mips32-mti-elf
sudo wget https://github.com/madcock/sf2000_multicore_toolchain/releases/download/v1.0/mips-mti-elf-2019.09-03-2.tar.gz
sudo tar -xzf mips-mti-elf-2019.09-03-2.tar.gz
sudo mv 2019.09-03-2 /opt/mips32-mti-elf/
```
*(Or verify that `/opt/mips32-mti-elf/2019.09-03-2/bin/mips-mti-elf-gcc` exists).*

---

## 🚀 Quick Build Guide

### Step 1: Clone Repositories
Place both repositories next to each other in the same directory:

```bash
# 1. Clone sf2000_multicore framework (Desoxyn's fork)
git clone --depth 1 https://github.com/Trademarked69/sf2000_multicore.git

# 2. Clone this repo
git clone https://github.com/Synaps33/sf2000-frogui-modded.git
```

Folder structure:
```text
parent_directory/
  ├── sf2000_multicore/
  └── sf2000-frogui-modded/
```

### Step 2: Build

#### On Windows (CMD / PowerShell):
- Double click **`build_sf2000.bat`** (for SF2000)
- Double click **`build_gb300.bat`** (for GB300)

*The batch scripts will auto-detect your `sf2000_multicore` directory, copy modified sources, compile inside WSL, and place the output binary in the current folder.*

#### On Linux / WSL:
```bash
cd sf2000-frogui-modded
chmod +x build_sf2000.sh build_gb300.sh

# For SF2000:
./build_sf2000.sh

# For GB300:
./build_gb300.sh
```

---

## 📦 Output Binaries & Installation

After a successful build, the following files will be produced:
- `core_87000000` (for SF2000)
- `core_87000000_gb300` (for GB300)

### Installation on SD Card:
1. **SF2000**:
   - Copy `core_87000000` to `SD:\SF2000\cores\.sf2k` (and/or `SD:\SF2000\cores\menu.sf2k`).
2. **GB300**:
   - Copy `core_87000000_gb300` as `core_87000000` to `SD:\GB300V2\cores\.sf2k`.
3. **Themes & Options**:
   - Copy `frogui.opt` to the SD card root.
   - Copy the `THEMES/` folder to the SD card root.

---

## 👥 Credits

- **Prosty (Tomasz Zubertowski)** - Original FrogUI Creator
- **Desoxyn (Trademarked69)** - sf2000_multicore development
- **Q_ta (Q_ta_s)** - Enhancements & fixes
- **angree** - [sf2000-frogui-modded](https://github.com/angree/sf2000-frogui-modded)
- **Synaps33** - Modded fork, XMB waves, PNG/theme additions, portable build system

---

## 📄 License
CC BY-NC-SA 4.0 - See LICENSE file.

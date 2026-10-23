#!/bin/sh
# Baut den Genesis-Plus-GX-libretro-Kern fuer automatische Tests (nur Linux, z. B. Claude-Sitzung).
# Ergaenzt Exporte fuer VRAM/CRAM/RAM/PC (retro_br_*), die mdemu.py nutzt.
set -e
cd "$(dirname "$0")"
[ -d gpgx ] || git clone --depth 1 https://github.com/libretro/Genesis-Plus-GX.git gpgx
cd gpgx
grep -q retro_br_vram libretro/libretro.c || cat >> libretro/libretro.c <<'C'

/* Buck-Rogers-Projekt: Zugriff auf VDP- und CPU-Zustand fuer Tests */
RETRO_API void *retro_br_vram(void) { return vram; }
RETRO_API void *retro_br_cram(void) { return cram; }
RETRO_API void *retro_br_vdpreg(void) { return reg; }
RETRO_API void *retro_br_ram(void) { return work_ram; }
RETRO_API unsigned retro_br_pc(void) { return m68k_get_reg(M68K_REG_PC); }
C
make -f Makefile.libretro -j8 >/dev/null
ls -l genesis_plus_gx_libretro.so

#!/usr/bin/env python3
"""Minimaler libretro-Frontend (Genesis Plus GX) fuer automatische Tests ohne Bildschirm."""
import ctypes as C, os, numpy as np
from PIL import Image

CORE = os.environ.get("GPGX_CORE", os.path.join(os.path.dirname(os.path.abspath(__file__)), "gpgx", "genesis_plus_gx_libretro.so"))
SYSDIR = os.path.join(os.path.dirname(os.path.abspath(__file__)), "sys")

class GameInfo(C.Structure):
    _fields_ = [("path", C.c_char_p), ("data", C.c_void_p), ("size", C.c_size_t), ("meta", C.c_char_p)]

class Variable(C.Structure):
    _fields_ = [("key", C.c_char_p), ("value", C.c_char_p)]

ENV_T = C.CFUNCTYPE(C.c_bool, C.c_uint, C.c_void_p)
VID_T = C.CFUNCTYPE(None, C.c_void_p, C.c_uint, C.c_uint, C.c_size_t)
AUD_T = C.CFUNCTYPE(None, C.c_int16, C.c_int16)
AUDB_T = C.CFUNCTYPE(C.c_size_t, C.c_void_p, C.c_size_t)
POLL_T = C.CFUNCTYPE(None)
STATE_T = C.CFUNCTYPE(C.c_int16, C.c_uint, C.c_uint, C.c_uint, C.c_uint)

# libretro Joypad-IDs
BTN = {"B": 0, "Y": 1, "SELECT": 2, "START": 3, "UP": 4, "DOWN": 5, "LEFT": 6, "RIGHT": 7,
       "A": 8, "X": 9, "L": 10, "R": 11}
# Mega Drive (GPGX-Standard): B->A, A->B? GPGX: RETRO B = MD B, A = MD C, Y = MD A
MD = {"A": "Y", "B": "B", "C": "A", "START": "START", "UP": "UP", "DOWN": "DOWN", "LEFT": "LEFT", "RIGHT": "RIGHT"}


class MD_Emu:
    _n = 0

    def __init__(self, rom_path, sram=None):
        os.makedirs(SYSDIR, exist_ok=True)
        # Jede Instanz braucht eine eigene Kopie der Bibliothek (globaler Zustand im Kern)
        MD_Emu._n += 1
        core = CORE
        if MD_Emu._n > 1:
            import shutil, tempfile
            core = os.path.join(tempfile.gettempdir(), "gpgx_%d_%d.so" % (os.getpid(), MD_Emu._n))
            shutil.copyfile(CORE, core)
        self.lib = C.CDLL(core)
        self.frame = None
        self.pressed = set()
        self._sysdir = C.c_char_p(SYSDIR.encode())
        self._keep = []
        self.cb_env = ENV_T(self._env)
        self.cb_vid = VID_T(self._vid)
        self.cb_aud = AUD_T(lambda l, r: None)
        self.cb_audb = AUDB_T(lambda d, n: n)
        self.cb_poll = POLL_T(lambda: None)
        self.cb_state = STATE_T(self._state)
        L = self.lib
        L.retro_set_environment(self.cb_env)
        L.retro_set_video_refresh(self.cb_vid)
        L.retro_set_audio_sample(self.cb_aud)
        L.retro_set_audio_sample_batch(self.cb_audb)
        L.retro_set_input_poll(self.cb_poll)
        L.retro_set_input_state(self.cb_state)
        L.retro_init()
        data = open(rom_path, "rb").read()
        self._rom = C.create_string_buffer(data, len(data))
        gi = GameInfo(rom_path.encode(), C.cast(self._rom, C.c_void_p), len(data), None)
        if not L.retro_load_game(C.byref(gi)):
            raise RuntimeError("retro_load_game fehlgeschlagen")
        for n in ("retro_br_vram", "retro_br_cram", "retro_br_ram", "retro_br_vdpreg"):
            getattr(L, n).restype = C.c_void_p
        L.retro_get_memory_data.restype = C.c_void_p
        L.retro_get_memory_size.restype = C.c_size_t
        L.retro_serialize_size.restype = C.c_size_t
        if sram is not None:
            p = L.retro_get_memory_data(0)
            n = L.retro_get_memory_size(0)
            C.memmove(p, sram, min(n, len(sram)))

    def _env(self, cmd, data):
        cmd &= 0xFFFF
        if cmd in (9, 31):  # SYSTEM_DIRECTORY, SAVE_DIRECTORY
            C.cast(data, C.POINTER(C.c_char_p))[0] = self._sysdir
            return True
        if cmd == 10:  # SET_PIXEL_FORMAT
            return True
        if cmd == 15:  # GET_VARIABLE
            v = C.cast(data, C.POINTER(Variable))[0]
            return False
        if cmd == 27:  # GET_LOG_INTERFACE
            return False
        return False

    def _vid(self, data, w, h, pitch):
        if not data:
            return
        buf = C.string_at(data, pitch * h)
        a = np.frombuffer(buf, dtype=np.uint16).reshape(h, pitch // 2)[:, :w]
        r = ((a >> 11) & 0x1F) << 3
        g = ((a >> 5) & 0x3F) << 2
        b = (a & 0x1F) << 3
        self.frame = np.dstack([r, g, b]).astype(np.uint8)

    def _state(self, port, device, index, id_):
        if port != 0 or device != 1:
            return 0
        for k in self.pressed:
            if BTN[MD[k]] == id_:
                return 1
        return 0

    def run(self, frames=1, keys=()):
        self.pressed = set(keys)
        for _ in range(frames):
            self.lib.retro_run()
        self.pressed = set()

    def press(self, key, hold=4, after=10):
        self.run(hold, [key])
        self.run(after)

    def shot(self, path):
        Image.fromarray(self.frame).resize((self.frame.shape[1] * 2, self.frame.shape[0] * 2), Image.NEAREST).save(path)

    def vram(self):
        b = bytearray(C.string_at(self.lib.retro_br_vram(), 0x10000))
        b[0::2], b[1::2] = b[1::2], b[0::2]   # GPGX legt Worte little endian ab
        return bytes(b)

    def ram(self):
        b = bytearray(C.string_at(self.lib.retro_br_ram(), 0x10000))
        b[0::2], b[1::2] = b[1::2], b[0::2]
        return bytes(b)

    def cram(self):
        raw = C.string_at(self.lib.retro_br_cram(), 0x80)
        cols = []
        for i in range(64):
            v = raw[2 * i] | (raw[2 * i + 1] << 8)
            r, g, b = (v & 7), (v >> 3) & 7, (v >> 6) & 7
            cols.append((r * 36, g * 36, b * 36))
        return cols

    def pc(self):
        return self.lib.retro_br_pc()

    def sram(self):
        p = self.lib.retro_get_memory_data(0)
        n = self.lib.retro_get_memory_size(0)
        return C.string_at(p, n)

    def save_state(self):
        n = self.lib.retro_serialize_size()
        buf = C.create_string_buffer(n)
        self.lib.retro_serialize(buf, n)
        return buf.raw

    def load_state(self, data):
        buf = C.create_string_buffer(data, len(data))
        self.lib.retro_unserialize(buf, len(data))


def tiles_image(vram, cram, first, count, pal=0, cols=32, scale=3):
    rows = (count + cols - 1) // cols
    img = np.zeros((rows * 8, cols * 8, 3), np.uint8)
    for t in range(count):
        d = vram[(first + t) * 32:(first + t) * 32 + 32]
        for y in range(8):
            for x in range(8):
                byte = d[y * 4 + x // 2]
                px = (byte >> 4) if x % 2 == 0 else (byte & 15)
                img[(t // cols) * 8 + y, (t % cols) * 8 + x] = cram[pal * 16 + px] if px else (40, 0, 40)
    return Image.fromarray(img).resize((cols * 8 * scale, rows * 8 * scale), Image.NEAREST)

Buck Rogers: Countdown to Doomsday (Sega Mega Drive / Genesis) - German fan translation
Version 1.0, date: {DATE}

German localization
  Project lead, translation, testing: Karlhungus

FILES
  Buck Rogers - Countdown to Doomsday (Deutsch).bps   patch (recommended, e.g. Floating IPS / beat)
  Buck Rogers - Countdown to Doomsday (Deutsch).ips   same patch in IPS format

REQUIRED ROM
  Buck Rogers - Countdown to Doomsday (USA, Europe)
  1,048,576 bytes, CRC32 {ORIG_CRC}
  Patched result: 2,097,152 bytes, CRC32 {NEU_CRC}

WHAT IS TRANSLATED
  Menus, system messages, items, monsters, all dialogue and event text, intro graphics
  text and the end credits. The game font has upper case only (German "ss" for sharp s).
  Proper names (NEO, RAM, Buck Rogers, Wilma Deering, Scot.DOS ...) are kept.
  Copyright lines on the title screen remain in English.

OPTIONS MENU (NEW)
  A new OPTIONEN icon is available in the main menu and the START menu. All defaults
  match the original game. Settings last until the console is switched off.
  - Space and ground combat: own hits / enemy misses (0 to 100 %)
  - Invulnerable ship
  - Unlimited ammunition: in space combat every character can use every intact weapon,
    with no per-round limit, no ammunition use and at any range
  - Space encounters: normal, half, none, Merkur+ (Mercurian cruisers more often,
    once the story allows them)
  - Attribute rolls, hit points on level-up, experience, credits from loot
  - Healing after combat

CHARACTER CREATION TIP
  Spend points on the career skill: the single icon at the top right of the training
  screen. Without points in "pilot rocket/juryrig" the team has no pilot in space
  combat, even if a character is a Rocketjock.

KNOWN ISSUES
  None known.

TECHNICAL NOTES
  The ROM is expanded to 2 MB. German text is stored uncompressed above $100000 and
  read through small hooks in the original code; graphics are re-packed with the
  game's own LZW format. Tested with Ares v147, not on real hardware or a flash cart.

This is a non-commercial fan project. Buck Rogers is a trademark of the Dille Family
Trust; the game is by SSI and Electronic Arts. No ROM is distributed.

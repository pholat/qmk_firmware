# MCU name
MCU = atmega32u4

# Bootloader selection
#   Teensy       halfkay
#   Pro Micro    caterina
#   Atmel DFU    atmel-dfu
#   LUFA DFU     lufa-dfu
#   QMK DFU      qmk-dfu
#   ATmega32A    bootloadHID
#   ATmega328P   USBasp

BOOTLOADER = halfkay    # teensy
# BOOTLOADER = caterina # pro micro

# Build Options
#   comment out to disable the options.
#
BOOTMAGIC_ENABLE        = no  # Virtual DIP switch configuration(+1000)
MIDI_ENABLE             = no  # MIDI support (+2400 to 4200)
POINTING_DEVICE_ENABLE  = no
MOUSEKEY_ENABLE         = no  # Mouse keys(+4700)
EXTRAKEY_ENABLE         = yes # Audio control and System control(+450)
CONSOLE_ENABLE          = no  # Console for debug(+8000)
COMMAND_ENABLE          = no  # Commands for debug and configuration
CUSTOM_MATRIX           = yes # Custom matrix file for the Dactyl
NKRO_ENABLE             = yes # USB Nkey Rollover
UNICODE_ENABLE          = yes # Unicode
SWAP_HANDS_ENABLE       = yes # Allow swapping hands of keyboard
SLEEP_LED_ENABLE        = no
API_SYSEX_ENABLE        = no
RGBLIGHT_ENABLE         = no

# project specific files, add board_init.c to use UART for console output
SRC = twimaster.c matrix.c # board_init.c

# add uart.c for UART output:
# QUANTUM_LIB_SRC += uart.c

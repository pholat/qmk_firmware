# Dactyl

You can build dactyl keyboard with any board supported by qmk, it's just a matter on how much time you want to invest.

This handwired config can easily support 2 basic boards as both use the same uC
- [build with teensy](build with teensy)
- [pro-micro](build with pro micro)

As this is purely software matter you can:
- `DIODE_DIRECTION` to `ROW2COL` or `COL2ROW` : this doesn't matter but is frustrating at first when you handwire 
- have any order of row and col keys as long as:
    - on board with uC board you select any GPIO you have access to
    - on board with expander you are limited with:
        - GPIO bank you are working with: all pins A have to be either COL or ROW (same with bank B)
        - mapping these pins order requires changes in function: `read_cols_on_row` in matrix.c file see: [change expander pins order](change expander pins order) this is bothersome
- with little changes just print messages via serial UART on both teensy and pro-micro - please do not debug blindly. I considered USB HID logging but wasn't motivated enough to check it. [enable logging via uart](enable logging via uart)

# main teensy - pro-micro differences for this build

- teensy have neat teensy bootloader
- teensy have better USB connector
- teensy have more pins if it matters for you
- teensy is tiny bit bigger

I broke one USB micro port during build as these are only soldered on top.
It's best to consider dactyl print with flat base and USB expander screwed into it

# Builds

## teensy

See https://github.com/adereth/dactyl-keyboard

Teensy uses [Teensy Loader](https://www.pjrc.com/teensy/loader.html).

Linux users need to modify udev rules as described on the [Teensy
Linux page].  Some distributions provide a binary, maybe called
`teensy-loader-cli`.

[Teensy Linux page]: https://www.pjrc.com/teensy/loader_linux.html

To flash the firmware:

  - Build the firmware with `make handwired/dactyl:<keymapname>`, for example `make handwired/dactyl:default`
  - This will result in a hex file called `handwired_dactyl_<keymapname>.hex`, e.g.
    `handwired_dactyl_default.hex`

  - Start the teensy loader.

  - Load the .hex file into it.

  - Put the Teensy in firmware-loading mode:
    * If your current layout has a RESET key, press it.
    * If you lack a RESET key, press the reset button on the Teensy board itself.

  - Click the button in the Teensy app to download the firmware.

To flash with ´teensy-loader-cli´:

  - Build the firmware as above

  - Run `<path/to/>teensy_loader_cli -mmcu=atmega32u4 -w handwired_dactyl_<keymapname>.hex`

  - If you like, you can do both at once: `make handwired/dactyl:<keymapname>:teensy`

  - Put the Teensy in firmware-loading mode:
    * If your current layout has a RESET key, press it.
    * If you lack a RESET key, press the reset button on the Teensy board itself.

## pro-micro

### software changes

because both boards are pretty similar, there is little to none changes needed to be made in software:

- change pin mappings in `config.h` for pins you use with pro-micro, for my case it was:
```
#define MATRIX_ONBOARD_ROW_PINS { F6, F7, B1, B3, B2, B6 }
#define MATRIX_ONBOARD_COL_PINS { 0, 0, 0, 0, 0, 0, D4, C6, D7, E6, B4, B5 }
```
- change `bootloader` to `caterina` in rules.mk
- tweak keypap.c to adjust which key does what

WARNING: you might need to change frequency depending on your pro micro - or I read. I had no such issues.


### build and load

Build and flash pro-micro firmware:
  - `qmk config user.keyboard=handwired/dactyl`
  - `make handwired/dactyl:default` - build
  - `qmk flash`
  - reset pro-micro on prompt from cli with reset button (or jumper)
  - waaaaait for it and if needed - unplug and plug in your keyboard

### Configuration checks on linux

if you are not getting keys right - ie have reverse column order as I did on left hand you can use:
`xev` to check what exact keys are sent on each keypress
this is the best tool to adjust what key does what in keymap.c

if you only trust in code and print's enable logging and debug till you are content

# Additional changes which you may consider

## enable logging via uart

in rules.mk

* set `CONSOLE_ENABLE = yes        # Console for debug`
* uncomment `board_init.c` in `SRC`
* uncomment `QUANTUM_LIB_SRC += uart.c`

You can change how much you want to log with: `debug.c` qmk file

## change expander pins order

Expander is mapped in order - therefore soldering it in order is of upmost importance.
If you solder it in different order (but still one bank to row and one bank to col) then you can easily change it in code.

I had config:
`#define DIODE_DIRECTION COL2ROW`
so in:
`static bool read_cols_on_row(matrix_row_t current_matrix[], uint8_t current_row) {`
I had to change pin order as ROW1 was read as PIN0 etc. - and I've them in reverse

please see:
`NON_STANDARD_ROW` definition and play with rows arrangements.

You can use the very same code for COLS if your direction is ROW2COL
just tweak it in:

`static bool read_rows_on_col(matrix_row_t current_matrix[], uint8_t current_col)`

With some effort this could be split to separate funcions and preferably files and easilly configurable in makefile, I didn't see much worth to do it just for myself.

## add TRRS cable later

I had no issues without TRRS cable - I just used some rainbow cable I had at hand + a piece of line.
This might save you some time while waiting for all the pieces - wait for TRRS is not worth it - start making!

## add additional buttons, functionalities

Even with my pro-micro build there are a few pins free



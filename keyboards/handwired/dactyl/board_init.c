#include <uart.h>
#include <print.h>


/// sendchar used by lufa
int8_t lolchar(uint8_t c) {
    uart_putchar(c);
    return 0;
}

/// initialize uart on pro micro to 115200
void matrix_setup(void)
{
    uart_init(115200);
    print_set_sendchar(lolchar);
}

/// tel console ready - just to know that everything started right
void keyboard_pre_init_user(void)
{
    print("1: INITIALIZATION DONE\n");
}

#include "ch.h"
#include "hal.h"

uint32_t test_value = 0;

int main(void) {
    halInit();
    chSysInit();
    while (true) {
        palToggleLine(LINE_LED_GREEN);
        test_value = test_value + 1;
        chThdSleepMilliseconds(1000);
    }
}

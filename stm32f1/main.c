#include <stdint.h>
#include "streg.h"


int main(void) {
    RCC_CR |= (1 << 16);              // HSEON = 1, start external oscillator
    while (!(RCC_CR & (1 << 17)));
    RCC_APB2ENR |= (1 << 4) | (1 << 5);
    RCC_APB1ENR |= (1 << 0)|(1 << 1);
    GPIOD_CRH &= ~(0xF << 12);
    GPIOD_CRH |=  (0x3 << 12);   // PD11 push-pull output, 50MHz
    GPIOD_BSRR |= (1 << 11);     // PD11 high
    delay_ms(200);
    GPIOC_CRL &= ~(0xF << 24);
    GPIOC_CRL |=  (0x3 << 24);   // PC6 push-pull output, 50MHz

    while (1) {
    GPIOC_BSRR |= (1 << 6);      // PC6 high
    delay_ms(200);
    GPIOC_BSRR |= (1 << 22);      // PC6 high
    delay_ms(200);
    }

}

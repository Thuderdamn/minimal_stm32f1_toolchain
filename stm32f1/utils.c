#include"streg.h"
#include <stdio.h>
#include <stdint.h>
void delay_ms(volatile uint32_t time) {
    RCC_CFGR |= (1 << 0);           // SW = 01, select HSE as SYSCLK
    while (((RCC_CFGR >> 2) & 0x3) != 1);
    TIM2_CR1 |= 0 << 8| 0 << 7|0 << 5|1 << 4|0 << 3|1 << 0;
    while (!(RCC_CR & (1 << 17)));
    TIM2_PSC = 7999;
    TIM2_SR &= ~(1 << 0);
    TIM2_CNT = time;
     while (!(TIM2_SR & (1 << 0)));
     TIM2_CR1 &= ~(1 << 0);     // CEN = 0, stop timer
     TIM2_SR &= ~(1 << 0);
}

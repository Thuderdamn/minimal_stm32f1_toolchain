#ifndef STREG_H
#define STREG_H
#include <stdint.h>
#define TIM2_BASE 0x40000000
#define TIM3_BASE 0x40000400
#define RCC_BASE    0x40021000
#define GPIOC_BASE  0x40011000  // change to GPIOB/C/etc as needed
#define RCC_CR    (*(volatile uint32_t *)(RCC_BASE))
#define RCC_CFGR    (*(volatile uint32_t *)(RCC_BASE+0x04))
#define GPIOC_ODR    (*(volatile uint32_t *)(GPIOC_BASE + 0x0C))
#define RCC_APB1ENR  (*(volatile uint32_t *)(RCC_BASE + 0x1C))
#define RCC_APB2ENR     (*(volatile uint32_t *)(RCC_BASE + 0x18))
#define GPIOC_CRH  (*(volatile uint32_t *)(GPIOC_BASE + 0x04))
#define GPIOC_CRL  (*(volatile uint32_t *)(GPIOC_BASE))
#define GPIOC_BSRR  (*(volatile uint32_t *)(GPIOC_BASE + 0x10))
#define GPIOD_BASE  0x40011400  // change to GPIOB/C/etc as needed
#define GPIOD_ODR    (*(volatile uint32_t *)(GPIOD_BASE + 0x0C))
#define GPIOD_CRH  (*(volatile uint32_t *)(GPIOD_BASE + 0x04))
#define GPIOD_CRL  (*(volatile uint32_t *)(GPIOD_BASE))
#define GPIOD_BSRR  (*(volatile uint32_t *)(GPIOD_BASE + 0x10))
#define TIM2_CR1  (*(volatile uint32_t *)(TIM2_BASE))
#define TIM2_CR2  (*(volatile uint32_t *)(TIM2_BASE+0x04))
#define TIM2_SMCR  (*(volatile uint32_t *)(TIM2_BASE+0x08))
#define TIM2_SR  (*(volatile uint32_t *)(TIM2_BASE+0x10))
#define TIM2_EGR  (*(volatile uint32_t *)(TIM2_BASE+0x14))
#define TIM2_CCRM1  (*(volatile uint32_t *)(TIM2_BASE+0x18))
#define TIM2_CCRM2  (*(volatile uint32_t *)(TIM2_BASE+0x1C))
#define TIM2_CCER  (*(volatile uint32_t *)(TIM2_BASE+0x20))
#define TIM2_CNT  (*(volatile uint32_t *)(TIM2_BASE+0x24))
#define TIM2_PSC  (*(volatile uint32_t *)(TIM2_BASE+0x28))
#define TIM2_CCR1  (*(volatile uint32_t *)(TIM2_BASE+0x34))
#define TIM2_CCR2  (*(volatile uint32_t *)(TIM2_BASE+0x38))
#define TIM2_CCR3  (*(volatile uint32_t *)(TIM2_BASE+0x3C))
#define TIM2_CCR4  (*(volatile uint32_t *)(TIM2_BASE+0x40))
#define TIM3_CR1  (*(volatile uint32_t *)(TIM2_BASE))
#define TIM3_CR2  (*(volatile uint32_t *)(TIM2_BASE+0x04))
#define TIM3_SMCR  (*(volatile uint32_t *)(TIM2_BASE+0x08))
#define TIM3_SR  (*(volatile uint32_t *)(TIM2_BASE+0x10))
#define TIM3_EGR  (*(volatile uint32_t *)(TIM2_BASE+0x14))
#define TIM3_CCRM1  (*(volatile uint32_t *)(TIM2_BASE+0x18))
#define TIM3_CCRM2  (*(volatile uint32_t *)(TIM2_BASE+0x1C))
#define TIM3_CCER  (*(volatile uint32_t *)(TIM2_BASE+0x20))
#define TIM3_CNT  (*(volatile uint32_t *)(TIM2_BASE+0x24))
#define TIM3_PSC  (*(volatile uint32_t *)(TIM2_BASE+0x28))
#define TIM3_CCR1  (*(volatile uint32_t *)(TIM2_BASE+0x34))
#define TIM3_CCR2  (*(volatile uint32_t *)(TIM2_BASE+0x38))
#define TIM3_CCR3  (*(volatile uint32_t *)(TIM2_BASE+0x3C))
#define TIM3_CCR4  (*(volatile uint32_t *)(TIM2_BASE+0x40))
void usart1_init(void);
void delay_ms(volatile uint32_t time);
#endif

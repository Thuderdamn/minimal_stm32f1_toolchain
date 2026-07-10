.syntax unified
.cpu cortex-m3
.thumb

/* Symbols provided by the linker script */
.word _sidata
.word _sdata
.word _edata
.word _sbss
.word _ebss
.word _estack

.section .isr_vector, "a", %progbits
.type g_pfnVectors, %object
g_pfnVectors:
    .word _estack               /* 0   initial stack pointer */
    .word Reset_Handler         /* 1   reset */
    .word NMI_Handler           /* 2 */
    .word HardFault_Handler     /* 3 */
    .word MemManage_Handler     /* 4 */
    .word BusFault_Handler      /* 5 */
    .word UsageFault_Handler    /* 6 */
    .word 0                     /* 7   reserved */
    .word 0                     /* 8   reserved */
    .word 0                     /* 9   reserved */
    .word 0                     /* 10  reserved */
    .word SVC_Handler           /* 11 */
    .word DebugMon_Handler      /* 12 */
    .word 0                     /* 13  reserved */
    .word PendSV_Handler        /* 14 */
    .word SysTick_Handler       /* 15 */

    /* STM32F103 IRQs (subset — extend as you actually use peripherals) */
    .word WWDG_IRQHandler            /* 16 */
    .word PVD_IRQHandler              /* 17 */
    .word TAMPER_IRQHandler           /* 18 */
    .word RTC_IRQHandler              /* 19 */
    .word FLASH_IRQHandler            /* 20 */
    .word RCC_IRQHandler               /* 21 */
    .word EXTI0_IRQHandler             /* 22 */
    .word EXTI1_IRQHandler             /* 23 */
    .word EXTI2_IRQHandler             /* 24 */
    .word EXTI3_IRQHandler             /* 25 */
    .word EXTI4_IRQHandler             /* 26 */
    .word DMA1_Channel1_IRQHandler     /* 27 */
    .word DMA1_Channel2_IRQHandler     /* 28 */
    .word DMA1_Channel3_IRQHandler     /* 29 */
    .word DMA1_Channel4_IRQHandler     /* 30 */
    .word DMA1_Channel5_IRQHandler     /* 31 */
    .word DMA1_Channel6_IRQHandler     /* 32 */
    .word DMA1_Channel7_IRQHandler     /* 33 */
    .word ADC1_2_IRQHandler            /* 34 */
    .word USB_HP_CAN1_TX_IRQHandler    /* 35 */
    .word USB_LP_CAN1_RX0_IRQHandler   /* 36 */
    .word CAN1_RX1_IRQHandler          /* 37 */
    .word CAN1_SCE_IRQHandler          /* 38 */
    .word EXTI9_5_IRQHandler           /* 39 */
    .word TIM1_BRK_IRQHandler          /* 40 */
    .word TIM1_UP_IRQHandler           /* 41 */
    .word TIM1_TRG_COM_IRQHandler      /* 42 */
    .word TIM1_CC_IRQHandler           /* 43 */
    .word TIM2_IRQHandler              /* 44 */
    .word TIM3_IRQHandler              /* 45 */
    .word TIM4_IRQHandler              /* 46 */
    .word I2C1_EV_IRQHandler           /* 47 */
    .word I2C1_ER_IRQHandler           /* 48 */
    .word I2C2_EV_IRQHandler           /* 49 */
    .word I2C2_ER_IRQHandler           /* 50 */
    .word SPI1_IRQHandler              /* 51 */
    .word SPI2_IRQHandler              /* 52 */
    .word USART1_IRQHandler            /* 53 */
    .word USART2_IRQHandler            /* 54 */
    .word USART3_IRQHandler            /* 55 */
    .word EXTI15_10_IRQHandler         /* 56 */
    .word RTC_Alarm_IRQHandler         /* 57 */
    .word USBWakeUp_IRQHandler         /* 58 */
    .word TIM8_BRK_IRQHandler          /* 59 */
    .word TIM8_UP_IRQHandler           /* 60 */
    .word TIM8_TRG_COM_IRQHandler      /* 61 */
    .word TIM8_CC_IRQHandler           /* 62 */
    .word ADC3_IRQHandler              /* 63 */
    .word FSMC_IRQHandler              /* 64 */
    .word SDIO_IRQHandler              /* 65 */
    .word TIM5_IRQHandler              /* 66 */
    .word SPI3_IRQHandler              /* 67 */
    .word UART4_IRQHandler             /* 68 */
    .word UART5_IRQHandler             /* 69 */
    .word TIM6_IRQHandler              /* 70 */
    .word TIM7_IRQHandler              /* 71 */
    .word DMA2_Channel1_IRQHandler     /* 72 */
    .word DMA2_Channel2_IRQHandler     /* 73 */
    .word DMA2_Channel3_IRQHandler     /* 74 */
    .word DMA2_Channel4_5_IRQHandler   /* 75 */

.size g_pfnVectors, .-g_pfnVectors

.section .text.Reset_Handler
.weak Reset_Handler
.type Reset_Handler, %function
Reset_Handler:
    /* Copy .data from flash (_sidata) to SRAM (_sdata..._edata) */
    ldr r0, =_sdata
    ldr r1, =_edata
    ldr r2, =_sidata
    movs r3, #0
    b copy_data_loop_check

copy_data_loop:
    ldr r4, [r2, r3]
    str r4, [r0, r3]
    adds r3, r3, #4

copy_data_loop_check:
    adds r4, r0, r3
    cmp r4, r1
    bcc copy_data_loop

    /* Zero .bss */
    ldr r0, =_sbss
    ldr r1, =_ebss
    movs r2, #0
    b zero_bss_loop_check

zero_bss_loop:
    str r2, [r0]
    adds r0, r0, #4

zero_bss_loop_check:
    cmp r0, r1
    bcc zero_bss_loop

    bl main
    b .              /* trap if main ever returns */

.size Reset_Handler, .-Reset_Handler

/* Default handler: infinite loop, used by all unimplemented weak vectors */
.section .text.Default_Handler, "ax", %progbits
Default_Handler:
    b .
.size Default_Handler, .-Default_Handler

/* Weak aliases — override any of these by defining the real symbol in C */
.macro def_irq_handler handler_name
    .weak \handler_name
    .thumb_set \handler_name, Default_Handler
.endm

def_irq_handler NMI_Handler
def_irq_handler HardFault_Handler
def_irq_handler MemManage_Handler
def_irq_handler BusFault_Handler
def_irq_handler UsageFault_Handler
def_irq_handler SVC_Handler
def_irq_handler DebugMon_Handler
def_irq_handler PendSV_Handler
def_irq_handler SysTick_Handler

def_irq_handler WWDG_IRQHandler
def_irq_handler PVD_IRQHandler
def_irq_handler TAMPER_IRQHandler
def_irq_handler RTC_IRQHandler
def_irq_handler FLASH_IRQHandler
def_irq_handler RCC_IRQHandler
def_irq_handler EXTI0_IRQHandler
def_irq_handler EXTI1_IRQHandler
def_irq_handler EXTI2_IRQHandler
def_irq_handler EXTI3_IRQHandler
def_irq_handler EXTI4_IRQHandler
def_irq_handler DMA1_Channel1_IRQHandler
def_irq_handler DMA1_Channel2_IRQHandler
def_irq_handler DMA1_Channel3_IRQHandler
def_irq_handler DMA1_Channel4_IRQHandler
def_irq_handler DMA1_Channel5_IRQHandler
def_irq_handler DMA1_Channel6_IRQHandler
def_irq_handler DMA1_Channel7_IRQHandler
def_irq_handler ADC1_2_IRQHandler
def_irq_handler USB_HP_CAN1_TX_IRQHandler
def_irq_handler USB_LP_CAN1_RX0_IRQHandler
def_irq_handler CAN1_RX1_IRQHandler
def_irq_handler CAN1_SCE_IRQHandler
def_irq_handler EXTI9_5_IRQHandler
def_irq_handler TIM1_BRK_IRQHandler
def_irq_handler TIM1_UP_IRQHandler
def_irq_handler TIM1_TRG_COM_IRQHandler
def_irq_handler TIM1_CC_IRQHandler
def_irq_handler TIM2_IRQHandler
def_irq_handler TIM3_IRQHandler
def_irq_handler TIM4_IRQHandler
def_irq_handler I2C1_EV_IRQHandler
def_irq_handler I2C1_ER_IRQHandler
def_irq_handler I2C2_EV_IRQHandler
def_irq_handler I2C2_ER_IRQHandler
def_irq_handler SPI1_IRQHandler
def_irq_handler SPI2_IRQHandler
def_irq_handler USART1_IRQHandler
def_irq_handler USART2_IRQHandler
def_irq_handler USART3_IRQHandler
def_irq_handler EXTI15_10_IRQHandler
def_irq_handler RTC_Alarm_IRQHandler
def_irq_handler USBWakeUp_IRQHandler
def_irq_handler TIM8_BRK_IRQHandler
def_irq_handler TIM8_UP_IRQHandler
def_irq_handler TIM8_TRG_COM_IRQHandler
def_irq_handler TIM8_CC_IRQHandler
def_irq_handler ADC3_IRQHandler
def_irq_handler FSMC_IRQHandler
def_irq_handler SDIO_IRQHandler
def_irq_handler TIM5_IRQHandler
def_irq_handler SPI3_IRQHandler
def_irq_handler UART4_IRQHandler
def_irq_handler UART5_IRQHandler
def_irq_handler TIM6_IRQHandler
def_irq_handler TIM7_IRQHandler
def_irq_handler DMA2_Channel1_IRQHandler
def_irq_handler DMA2_Channel2_IRQHandler
def_irq_handler DMA2_Channel3_IRQHandler
def_irq_handler DMA2_Channel4_5_IRQHandler

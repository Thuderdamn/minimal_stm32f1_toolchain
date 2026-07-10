/* Linker script for STM32F103VBT6 (128K flash, 20K SRAM) */

ENTRY(Reset_Handler)

MEMORY
{
    FLASH (rx)  : ORIGIN = 0x08000000, LENGTH = 128K
    SRAM  (rwx) : ORIGIN = 0x20000000, LENGTH = 20K
}

/* Top of stack = end of SRAM */
_estack = ORIGIN(SRAM) + LENGTH(SRAM);

SECTIONS
{
    /* Vector table + code + read-only data, lives in flash */
    .isr_vector :
    {
        . = ALIGN(4);
        KEEP(*(.isr_vector))
        . = ALIGN(4);
    } > FLASH

    .text :
    {
        . = ALIGN(4);
        *(.text)
        *(.text*)
        *(.rodata)
        *(.rodata*)
        . = ALIGN(4);
    } > FLASH

    /* Marks the end of code/rodata in flash; used as LMA for .data */
    _sidata = LOADADDR(.data);

    /* Initialized data: stored in flash, lives in SRAM at runtime */
    .data :
    {
        . = ALIGN(4);
        _sdata = .;
        *(.data)
        *(.data*)
        . = ALIGN(4);
        _edata = .;
    } > SRAM AT > FLASH

    /* Zero-initialized data: SRAM only, nothing to load from flash */
    .bss :
    {
        . = ALIGN(4);
        _sbss = .;
        *(.bss)
        *(.bss*)
        *(COMMON)
        . = ALIGN(4);
        _ebss = .;
    } > SRAM

    . = ALIGN(4);
    _end = .;
}

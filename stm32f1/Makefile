TARGET   = firmware
SRCS     = main.c utils.c
ASRCS    = stm32f103.s
LDSCRIPT = stm32f103.ld

CC      = arm-none-eabi-gcc
OBJCOPY = arm-none-eabi-objcopy
SIZE    = arm-none-eabi-size

# No FPU on Cortex-M3, unlike your F401 (M4F)
CPU_FLAGS = -mcpu=cortex-m3 -mthumb

CFLAGS  = $(CPU_FLAGS) -Wall -O0 -g -ffreestanding -nostdlib
LDFLAGS = $(CPU_FLAGS) -T$(LDSCRIPT) -nostdlib -Wl,--gc-sections -Wl,-Map=$(TARGET).map

OBJS = $(SRCS:.c=.o) $(ASRCS:.s=.o)

all: $(TARGET).elf $(TARGET).bin

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

%.o: %.s
	$(CC) $(CPU_FLAGS) -c $< -o $@

$(TARGET).elf: $(OBJS)
	$(CC) $(LDFLAGS) $(OBJS) -o $@
	$(SIZE) $@

$(TARGET).bin: $(TARGET).elf
	$(OBJCOPY) -O binary $< $@

flash: $(TARGET).bin
	st-flash write $(TARGET).bin 0x08000000

clean:
	rm -f *.o $(TARGET).elf $(TARGET).bin $(TARGET).map

.PHONY: all flash clean

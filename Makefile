######################################
# target
######################################
# do NOT leave space at the end of line
TARGET = gd32f103ret6_freertos


######################################
# building variables
######################################
# debug build?
DEBUG = 1
# optimization for size
OPT = -Os


#######################################
# paths
#######################################
# Build path
GCC_PATH ?= C:/"Program Files (x86)"/"GNU Arm Embedded Toolchain"/"10 2021.10"/bin
BUILD_DIR = build
SDK_ROOT = C:/Users/user/Documents/Code/GD32F10x_Firmware_Library_V2.3.0/
freertos = freertos/
segger_rtt = segger_rtt/
SRC_DIR = Src/
INC_DIR = Inc/

######################################
# source
######################################

# C sources
C_SOURCES = \
$(SDK_ROOT)Firmware/CMSIS/GD/GD32F10x/Source/system_gd32f10x.c \
$(SDK_ROOT)Firmware/GD32F10x_standard_peripheral/Source/gd32f10x_spi.c \
$(SDK_ROOT)Firmware/GD32F10x_standard_peripheral/Source/gd32f10x_bkp.c \
$(SDK_ROOT)Firmware/GD32F10x_standard_peripheral/Source/gd32f10x_can.c \
$(SDK_ROOT)Firmware/GD32F10x_standard_peripheral/Source/gd32f10x_exti.c \
$(SDK_ROOT)Firmware/GD32F10x_standard_peripheral/Source/gd32f10x_dac.c \
$(SDK_ROOT)Firmware/GD32F10x_standard_peripheral/Source/gd32f10x_wwdgt.c \
$(SDK_ROOT)Firmware/GD32F10x_standard_peripheral/Source/gd32f10x_enet.c \
$(SDK_ROOT)Firmware/GD32F10x_standard_peripheral/Source/gd32f10x_gpio.c \
$(SDK_ROOT)Firmware/GD32F10x_standard_peripheral/Source/gd32f10x_adc.c \
$(SDK_ROOT)Firmware/GD32F10x_standard_peripheral/Source/gd32f10x_fmc.c \
$(SDK_ROOT)Firmware/GD32F10x_standard_peripheral/Source/gd32f10x_dbg.c \
$(SDK_ROOT)Firmware/GD32F10x_standard_peripheral/Source/gd32f10x_timer.c \
$(SDK_ROOT)Firmware/GD32F10x_standard_peripheral/Source/gd32f10x_exmc.c \
$(SDK_ROOT)Firmware/GD32F10x_standard_peripheral/Source/gd32f10x_fwdgt.c \
$(SDK_ROOT)Firmware/GD32F10x_standard_peripheral/Source/gd32f10x_usart.c \
$(SDK_ROOT)Firmware/GD32F10x_standard_peripheral/Source/gd32f10x_misc.c \
$(SDK_ROOT)Firmware/GD32F10x_standard_peripheral/Source/gd32f10x_rcu.c \
$(SDK_ROOT)Firmware/GD32F10x_standard_peripheral/Source/gd32f10x_pmu.c \
$(SDK_ROOT)Firmware/GD32F10x_standard_peripheral/Source/gd32f10x_dma.c \
$(SDK_ROOT)Firmware/GD32F10x_standard_peripheral/Source/gd32f10x_i2c.c \
$(SDK_ROOT)Firmware/GD32F10x_standard_peripheral/Source/gd32f10x_rtc.c \
$(SDK_ROOT)Firmware/GD32F10x_standard_peripheral/Source/gd32f10x_sdio.c \
$(SDK_ROOT)Firmware/GD32F10x_standard_peripheral/Source/gd32f10x_crc.c \
$(segger_rtt)SEGGER_RTT.c \
$(segger_rtt)SEGGER_RTT_Syscalls_GCC.c \
$(segger_rtt)SEGGER_RTT_printf.c \
$(freertos)list.c \
$(freertos)queue.c \
$(freertos)stream_buffer.c \
$(freertos)croutine.c \
$(freertos)tasks.c \
$(freertos)event_groups.c \
$(freertos)timers.c \
$(freertos)port.c \
$(freertos)heap_4.c \
$(SRC_DIR)systick.c \
$(SRC_DIR)Src/user_task.c \
$(SRC_DIR)Src/gd32f10x_it.c \
$(SRC_DIR)Src/main.c 


# Include folders common to all targets

# C includes
C_INCLUDES =  \
-I$(SDK_ROOT)/Firmware/CMSIS \
-I$(SDK_ROOT)/Firmware/CMSIS/GD/GD32F10x/Include \
-I$(SDK_ROOT)/Firmware/GD32F10x_standard_peripheral/Include \
-I$(segger_rtt) \
-I$(freertos)/include \
-I$(INC_DIR) \

# ASM sources
ASM_SOURCES =  \
  $(SDK_ROOT)/Firmware/CMSIS/GD/GD32F10x/Source/GCC/startup_gd32f10x_xd.S \



#######################################
# binaries
#######################################
PREFIX = arm-none-eabi-
# The gcc compiler bin path can be either defined in make command via GCC_PATH variable (> make GCC_PATH=xxx)
# either it can be added to the PATH environment variable.
ifdef GCC_PATH
CC = $(GCC_PATH)/$(PREFIX)gcc
AS = $(GCC_PATH)/$(PREFIX)gcc -x assembler-with-cpp
CP = $(GCC_PATH)/$(PREFIX)objcopy
SZ = $(GCC_PATH)/$(PREFIX)size
else
CC = $(PREFIX)gcc
AS = $(PREFIX)gcc -x assembler-with-cpp
CP = $(PREFIX)objcopy
SZ = $(PREFIX)size
endif
HEX = $(CP) -O ihex
BIN = $(CP) -O binary -S
 
#######################################
# CFLAGS
#######################################
# cpu
CPU = -mcpu=cortex-m3

# fpu
# NONE for Cortex-M0/M0+/M3

# float-abi


# mcu
MCU = $(CPU) -mthumb $(FPU) $(FLOAT-ABI)

# macros for gcc
# AS defines
AS_DEFS = 

# C defines
C_DEFS =  \
-DUSE_STDPERIPH_DRIVER \
-DGD32F10X_XD 


# AS includes
AS_INCLUDES = 



# compile gcc flags
ASFLAGS += $(MCU)
ASFLAGS += $(AS_DEFS)
ASFLAGS += $(AS_INCLUDES)
ASFLAGS += $(OPT)
ASFLAGS += -Wall 
ASFLAGS += -fdata-sections 
ASFLAGS += -ffunction-sections

CFLAGS += $(MCU)
CFLAGS += $(C_DEFS)
CFLAGS += $(C_INCLUDES)
CFLAGS += $(OPT)
CFLAGS += -Wall
CFLAGS += -fdata-sections
CFLAGS += -ffunction-sections

ifeq ($(DEBUG), 1)
CFLAGS += -g -gdwarf-2
endif


# Generate dependency information
CFLAGS += -MMD -MP -MF"$(@:%.o=%.d)"


#######################################
# LDFLAGS
#######################################
# link script
LDSCRIPT = Link.ld

# libraries
LIBS = -lc -lm -lnosys 
LIBDIR = 
LDFLAGS = $(MCU) -u_printf_float -specs=nosys.specs -T$(LDSCRIPT) $(LIBDIR) $(LIBS) -Wl,-Map=$(BUILD_DIR)/$(TARGET).map,--cref -Wl,--gc-sections

# default action: build all
all: $(BUILD_DIR)/$(TARGET).elf $(BUILD_DIR)/$(TARGET).hex $(BUILD_DIR)/$(TARGET).bin


#######################################
# build the application
#######################################
# list of objects
OBJECTS = $(addprefix $(BUILD_DIR)/,$(notdir $(C_SOURCES:.c=.o)))
vpath %.c $(sort $(dir $(C_SOURCES)))
# list of ASM program objects
OBJECTS += $(addprefix $(BUILD_DIR)/,$(notdir $(ASM_SOURCES:.S=.o)))
vpath %.S $(sort $(dir $(ASM_SOURCES)))

$(BUILD_DIR)/%.o: %.c Makefile | $(BUILD_DIR) 
	$(CC) -c $(CFLAGS) -Wa,-a,-ad,-alms=$(BUILD_DIR)/$(notdir $(<:.c=.lst)) $< -o $@

$(BUILD_DIR)/%.o: %.S Makefile | $(BUILD_DIR)
	$(AS) -c $(CFLAGS) $< -o $@

$(BUILD_DIR)/$(TARGET).elf: $(OBJECTS) Makefile
	$(CC) $(OBJECTS) $(LDFLAGS) -o $@
	$(SZ) $@  

$(BUILD_DIR)/%.hex: $(BUILD_DIR)/%.elf | $(BUILD_DIR)
	$(HEX) $< $@
	
$(BUILD_DIR)/%.bin: $(BUILD_DIR)/%.elf | $(BUILD_DIR)
	$(BIN) $< $@	
	
$(BUILD_DIR):
	mkdir $@		

#######################################
# program
#######################################
erase:
	jlink -LoadFile build/$(TARGET).elf

#######################################
# clean up
#######################################
clean:
	-del $(BUILD_DIR)

#######################################
# dependencies
#######################################
-include $(wildcard $(BUILD_DIR)/*.d)

# *** EOF ***

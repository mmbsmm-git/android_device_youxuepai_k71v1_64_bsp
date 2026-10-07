DEVICE_PATH := device/youxuepai/k71v1_64_bsp

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := generic

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic
TARGET_BOARD_SUFFIX := _64
TARGET_USES_64_BIT_BINDER := true

# Platform
TARGET_BOARD_PLATFORM := mt6771
TARGET_BOOTLOADER_BOARD_NAME := k71v1_64_bsp

# Kernel Headers & Base
BOARD_KERNEL_BASE := 0x40078000
BOARD_KERNEL_PAGESIZE := 2048
BOARD_KERNEL_OFFSET := 0x00008000
BOARD_RAMDISK_OFFSET := 0x14f88000
BOARD_TAGS_OFFSET := 0x13f88000
BOARD_INCLUDE_RECOVERY_DTBO := true
BOARD_PREBUILT_DTBOIMAGE := $(DEVICE_PATH)/prebuilt/recovery_dtbo.img
# FIX: real kernel lives at kernel/kernel (touch-patched Himax), NOT prebuilt/kernel.
# prebuilt/kernel did not exist -> build could not find the prebuilt kernel.
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/kernel/kernel

# Kernel Command Line - 严格对齐原厂，去除非法参数
BOARD_KERNEL_CMDLINE := bootopt=64S3,32N2,64N2

# Partitions & Sizes (32MB)
BOARD_BOOTIMAGE_PARTITION_SIZE := 33554432
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 33554432
BOARD_HAS_NO_REAL_SDCARD := true
BOARD_HAS_NO_SELECT_BUTTON := true
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
BOARD_BUILD_SYSTEM_ROOT_IMAGE := true

# System Properties - 强制注入原厂关键属性
PRODUCT_PROPERTY_OVERRIDES += \
    ro.treble.enabled=true \
    ro.build.version.release=9 \
    ro.product.cpu.abilist64=arm64-v8a \
    ro.product.cpu.abilist=arm64-v8a,armeabi-v7a,armeabi \
    ro.product.cpu.abilist32=armeabi-v7a,armeabi \
    ro.board.platform=mt6771 \
    ro.mediatek.platform=MT6771 \
    ro.sf.hwrotation=0 \
    ro.product.device=k71v1_64_bsp \
    ro.product.model=P709 \
    ro.product.name=k71v1_64_bsp \
    ro.product.brand=alps \
    ro.product.manufacturer=alps \
    ro.zygote=zygote64_32

# OrangeFox Configuration
TW_THEME := portrait_hdpi
OF_SCREEN_H := 2000
OF_SCREEN_W := 1200
OF_MAINTAINER := 梅梅不是没没
OF_DEFAULT_KEYMASTER_VERSION := 4.0
OF_DISABLE_MIUI_SPECIFIC_FEATURES := 1
OF_TWRP_COMPATIBILITY_MODE := 1
OF_CLOCK_POS := 1
OF_USE_GREEN_LED := 0

# Tools Inclusion
TW_INCLUDE_CRYPTO := false
TW_INCLUDE_LPDUMP := false
TW_INCLUDE_RESETPROP := true
TW_INCLUDE_REPACKTOOLS := true
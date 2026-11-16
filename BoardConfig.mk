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
# !!! 硬约束（2026-10-11 根因）: MTK lk 的 boot_linux_fdt() 从内核 blob 尾部反向扫描
# FDT magic(d00dfeed) 取 DTB；找不到就 dtb_addr=0 解引用 -> 崩溃 -> 看门狗重启循环。
# 所以 kernel/kernel 必须是 [gzip(Image) + 原厂 110572B DTB]，缺 DTB 必死循环。
# 当前 kernel/kernel = 原厂补丁内核(gzip) + prebuilt/kernel_dtb(110572B)，共 9366062B。
# 校验/重建见 Lazy 仓库 slim_rec.py（会 FATAL 报错防止再次丢 DTB）。
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

# NOTE: PRODUCT_PROPERTY_OVERRIDES was REMOVED from here (it is a product variable
# and MUST NOT be assigned in BoardConfig.mk -> "readonly variable" build error).
# Recovery properties are now injected correctly via the static file
# recovery/root/prop.default (see device.mk PRODUCT_COPY_FILES), which is the only
# path that reaches the recovery ramdisk. Do NOT re-add product vars here.

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

# ===== 内部存储 / fstab 生效相关（2026-11-17 补回）=====
# 说明：这些变量在 BoardConfig.mk.bak 里原本就有，精简版被一起删掉了，
# 直接导致 TWRP 不把 /data/media 当内部存储 —— 即使 fstab 路径修好，
# Install 菜单仍可能找不到 /sdcard 里的 zip / img。

RECOVERY_SDCARD_ON_DATA := true
TW_INTERNAL_STORAGE_PATH := "/data/media"
TW_INTERNAL_STORAGE_MOUNT_POINT := "data"
TW_INCLUDE_CRYPTO_FBE := false
BOARD_HAS_SDCARD_INTERNAL := true
BOARD_SUPPRESS_EMMC_WIPE := true

# 亮度（bak 里有，精简版丢了；不影响 fstab，但顺手补回）
TW_BRIGHTNESS_PATH := "/sys/class/leds/lcd-backlight/brightness"
TW_MAX_BRIGHTNESS := 2047
TW_DEFAULT_BRIGHTNESS := 900

# ⚠️ 不要加 TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/twrp.fstab
# device.mk 已经用 PRODUCT_COPY_FILES 把 twrp.fstab 拷成
#   recovery/root/etc/twrp.fstab 和 recovery/root/etc/recovery.fstab
# 再加 TARGET_RECOVERY_FSTAB 会和构建系统生成同一目标，报
#   "Multiple build actions for .../etc/recovery.fstab" 重复拷贝错误。
# 两份都已经在 ramdisk 里，TWRP 优先读 /etc/twrp.fstab，足够。
#
# 如果哪天改走 TARGET_RECOVERY_FSTAB 路线，记得把 device.mk 第 6-8 行
# 那两条 PRODUCT_COPY_FILES 删掉，二选一。

# BoardConfig.mk - YOUXUEPAI P709/U60 (k71v1_64_bsp) MT6771
# Android 9 (userdebug), modeled on OrangeFox fox_9.0 official device trees (begonia/beryllium)
# Device tree generated from stock recovery.bin
# Touch: cap_touch@5d (mediatek,cap_touch), LCM: nt35595 FHD DSI (truly+nt50358)

TARGET_OTA_ASSERT_DEVICE := k71v1_64_bsp

DEVICE_PATH := device/youxuepai/k71v1_64_bsp

# For building with a minimal manifest (recovery-only) — allow missing deps
ALLOW_MISSING_DEPENDENCIES := true

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := generic
TARGET_USES_64_BIT_BINDER := true

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic

ENABLE_CPUSETS := true
ENABLE_SCHEDBOOST := true

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := k71v1_64_bsp
TARGET_NO_BOOTLOADER := true

# Platform
TARGET_BOARD_PLATFORM := mt6771
TARGET_BOARD_PLATFORM_GPU := mali-g72

# Screen density (panel 1200x2000, FHD-ish tablet)
TARGET_SCREEN_DENSITY := 320

# Kernel (prebuilt from stock boot.img, gzip zImage with embedded DTB; touch driver included)
BOARD_KERNEL_CMDLINE := bootopt=64S3,32N2,64N2 androidboot.selinux=permissive buildvariant=userdebug
BOARD_KERNEL_BASE := 0x40078000
BOARD_KERNEL_OFFSET := 0x00008000
BOARD_KERNEL_PAGESIZE := 2048
BOARD_KERNEL_TAGS_OFFSET := 0x13F88000
BOARD_RAMDISK_OFFSET := 0x14F88000
BOARD_KERNEL_IMAGE_NAME := Image.gz-dtb
BOARD_BOOTIMG_HEADER_VERSION := 1
TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_HEADER_ARCH := arm64
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/kernel/kernel
BOARD_MKBOOTIMG_ARGS := --kernel_offset $(BOARD_KERNEL_OFFSET)
BOARD_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOTIMG_HEADER_VERSION)

# Recovery DTBO (from stock recovery.bin, official OrangeFox 9.0 method)
BOARD_INCLUDE_RECOVERY_DTBO := true
BOARD_PREBUILT_DTBOIMAGE := $(DEVICE_PATH)/prebuilt/recovery_dtbo.img

# Partitions
# NOTE: Recovery build only needs boot/recovery sizes. system/vendor/userdata/cache
# are deliberately not hard-coded (a recovery image does not produce those partition
# images; resizing via GPT does not affect this tree).
BOARD_FLASH_BLOCK_SIZE := 131072
# Real boot/recovery partitions are 32 MiB per the stock GPT — keep the image within that
BOARD_BOOTIMAGE_PARTITION_SIZE := 33554432
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 33554432

# File systems
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_SUPPRESS_SECURE_ERASE := true
BOARD_HAS_NO_SELECT_BUTTON := true

# System-as-root (SAR): system mounts at "/" (per stock recovery.fstab)
BOARD_BUILD_SYSTEM_ROOT_IMAGE := true

# Workaround for "error copying vendor files to recovery ramdisk" / "TARGET_COPY_OUT_VENDOR
# must be set to 'vendor'" (same fix as OrangeFox fox_9.0 official begonia device)
TARGET_COPY_OUT_VENDOR := vendor

# Recovery
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/twrp.fstab
TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"
TARGET_RECOVERY_DEVICE_MODULES += twrpdecrypt libtwrptar
BOARD_HAS_NO_MISC_PARTITION := false
BOARD_SUPPRESS_EMMC_WIPE := true
BOARD_HAS_REMOVABLE_STORAGE := true
BOARD_HAS_SDCARD_INTERNAL := true

# Crypto
TW_INCLUDE_CRYPTO := true
TW_CRYPTO_FS_TYPE := "ext4"
TW_CRYPTO_REAL_BLKDEV := "/dev/block/platform/bootdevice/by-name/userdata"
TW_CRYPTO_MNT_POINT := "/data"
TW_INCLUDE_CRYPTO_FBE := true

# TWRP specific. NOTE: OrangeFox 9.0's GUI only ships portrait_hdpi and watch_mdpi
# themes (no landscape_*). Begonia official uses portrait_hdpi. The panel is a
# landscape tablet, so the UI may rotate / be small, but it compiles.
TW_THEME := portrait_hdpi
RECOVERY_SDCARD_ON_DATA := true
TW_EXCLUDE_DEFAULT_USB_INIT := true
TW_EXTRA_LANGUAGES := true
TW_INCLUDE_NTFS_3G := true
TW_INCLUDE_FUSE_EXFAT := true
TW_INCLUDE_FB2PNG := true
TW_INCLUDE_LIBRES := true
TW_USE_TOOLBOX := true
TW_BRIGHTNESS_PATH := "/sys/class/leds/lcd-backlight/brightness"
TW_MAX_BRIGHTNESS := 2047
TW_DEFAULT_BRIGHTNESS := 900
TW_EXCLUDE_TWRPAPP := true
TW_INCLUDE_NANO := true
TW_DEVICE_VERSION := 1
TW_HAS_EDL_MODE := true
TW_IGNORE_MISC_WIPE_DATA := true
TW_NO_USB_STORAGE := true
TW_DISABLE_MTP := false
TW_INTERNAL_STORAGE_PATH := "/data/media"
TW_INTERNAL_STORAGE_MOUNT_POINT := "data"
TW_EXTERNAL_STORAGE_PATH := "/external_sd"
TW_EXTERNAL_STORAGE_MOUNT_POINT := "external_sd"
TW_SKIP_COMPATIBILITY_CHECK := true
TW_SCREEN_BLANK_ON_BOOT := true
TWRP_INCLUDE_LOGCAT := true
TARGET_USES_LOGD := true
TARGET_USES_MKE2FS := true

# Mount points
BOARD_MOUNT_FS_TYPE := ext4
BOARD_ROOT_EXTRA_FOLDERS := boot_para metadata nvcfg nvdata
BOARD_ODMIMAGE_FILE_SYSTEM_TYPE := ext4

# ------------------------------------------------------------------
# OrangeFox Recovery (OFox) support
# OF_ build vars read from BoardConfig by the OrangeFox source tree.
# FOX_ vars must NOT go in .mk files - put them in vendorsetup.sh.
# ------------------------------------------------------------------
OF_TARGET_DEVICE_ABI := arm64-v8a
OF_AB_DEVICE_WITH_RECOVERY := false
OF_DISABLE_MIUI_SPECIFIC_FEATURES := true
# NOTE: OF_SUPPORT_ALL_BLOCK_OTA_UPDATES must NOT be combined with
# OF_DISABLE_MIUI_SPECIFIC_FEATURES / OF_TWRP_COMPATIBILITY_MODE (OrangeFox
# orangefox.mk checks this and aborts the build). This is not a MIUI device,
# so we keep the MIUI-disable + TWRP-compat flags instead.
OF_QUICK_BACKUP_LIST := "/boot;/system;/data;/vendor"
OF_TWRP_COMPATIBILITY_MODE := 1
OF_USE_MAGISKBOOT_FOR_ALL_PATCHES := 1
OF_FLASHLIGHT_ENABLE := 1
OF_USE_TWRP_SAR_DETECT := 1
OF_NO_TREBLE_COMPATIBILITY_CHECK := 1
# OrangeFox maintainer (shown on the About page)
# Maintainer. NOTE: OrangeFox's build injects its own quotes around this value,
# so do NOT wrap it in quotes here (would double-quote -> C++ literal-operator error).
OF_MAINTAINER := 梅梅不是没没
# Screen logical size (panel 1200x2000 portrait). UI scale hint for OFox.
# Combined with ro.sf.hwrotation=0 (see device.mk) OF shows in portrait.
OF_SCREEN_W := 1200
OF_SCREEN_H := 2000
# Keymaster version for decryption (Android 9 ships keymaster 4.0).
# Strongly recommended by OrangeFox to avoid getting stuck on the logo.
OF_DEFAULT_KEYMASTER_VERSION := 4.0

# Anti-rollback hack (build-time security patch level). Keeps the bootloader
# from rejecting a recovery whose security patch is older than the stock build.
PLATFORM_SECURITY_PATCH := 2099-12-31
VENDOR_SECURITY_PATCH := 2099-12-31

# device.mk - YOUXUEPAI P709/U60 (k71v1_64_bsp)
# Recovery-only config. The base product is provided by the product .mk files
# (embedded.mk + vendor/omni/config/common.mk), not here.

# Copy recovery fstab into ramdisk
PRODUCT_COPY_FILES += \
    device/youxuepai/k71v1_64_bsp/twrp.fstab:recovery/root/etc/twrp.fstab \
    device/youxuepai/k71v1_64_bsp/twrp.fstab:recovery/root/etc/recovery.fstab

# CRITICAL: static prop.default for recovery.
# Root cause: PRODUCT_PROPERTY_OVERRIDES only writes /system/build.prop, it NEVER
# flows into recovery's ramdisk prop.default. So OFRP's prop.default was the OmniROM
# default (eng/16.1.0/treble=false) - completely wrong for this device, causing the
# boot loop. The fix (recommended by a reviewing AI) is to drop the STOCK prop.default
# (11203B, from the factory recovery) into recovery/root/prop.default so the build
# system overwrites it verbatim.
# This copy is derived from the factory rec prop.default with ONLY two corrections:
#   1) ro.sf.hwrotation=90 -> 0  (factory rec is landscape; user REQUIRES portrait)
#   2) persist.sys.usb.config=none -> adb (recovery needs USB/ADB)
# Everything else is the factory value: ro.build.type=user, release=9, treble=true,
# abilist64=arm64-v8a, platform=mt6771, secure=1, full ro.noah.* set, OTA host, etc.
PRODUCT_COPY_FILES += \
    device/youxuepai/k71v1_64_bsp/recovery/root/prop.default:recovery/root/prop.default

# Custom default font for OrangeFox GUI (RobotoCondensed-Regular, verified to contain
# CJK glyphs so the zh_CN UI renders; user wanted a CJK-capable font for the recovery).
# Overrides TWRP's default RobotoCondensed-Regular.ttf inside the recovery ramdisk's twres.
PRODUCT_COPY_FILES += \
    device/youxuepai/k71v1_64_bsp/recovery/root/twres/fonts/RobotoCondensed-Regular.ttf:recovery/root/twres/fonts/RobotoCondensed-Regular.ttf

# Display orientation in recovery. The panel is physically portrait (1200x2000),
# so hwrotation=0 shows OrangeFox in portrait AND keeps touch coordinates aligned
# (physical portrait touch + no rotation = consistent). User preference = portrait.
# NOTE: slim_rec.py must NOT force hwrotation back to 90 (that was for the stock
# landscape rec); keep 0 here so the build stays portrait.
PRODUCT_PROPERTY_OVERRIDES += \
    ro.sf.hwrotation=0

# TWRP device settings
PRODUCT_PACKAGES += \
    twrp

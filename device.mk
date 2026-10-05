# device.mk - YOUXUEPAI P709/U60 (k71v1_64_bsp)
# Recovery-only config. The base product is provided by the product .mk files
# (embedded.mk + vendor/omni/config/common.mk), not here.

# Copy recovery fstab into ramdisk
PRODUCT_COPY_FILES += \
    device/youxuepai/k71v1_64_bsp/twrp.fstab:recovery/root/etc/twrp.fstab \
    device/youxuepai/k71v1_64_bsp/twrp.fstab:recovery/root/etc/recovery.fstab

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

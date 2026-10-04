# device.mk - YOUXUEPAI P709/U60 (k71v1_64_bsp)
# Recovery-only config. The base product is provided by the product .mk files
# (embedded.mk + vendor/omni/config/common.mk), not here.

# Copy recovery fstab into ramdisk
PRODUCT_COPY_FILES += \
    device/youxuepai/k71v1_64_bsp/twrp.fstab:recovery/root/etc/twrp.fstab \
    device/youxuepai/k71v1_64_bsp/twrp.fstab:recovery/root/etc/recovery.fstab

# Custom default font for OrangeFox GUI (JetBrainsMapleMono-Regular, contains CJK).
# Overrides TWRP's default RobotoCondensed-Regular.ttf inside the recovery ramdisk's twres.
PRODUCT_COPY_FILES += \
    device/youxuepai/k71v1_64_bsp/recovery/root/twres/fonts/RobotoCondensed-Regular.ttf:recovery/root/twres/fonts/RobotoCondensed-Regular.ttf

# Force default portrait orientation in recovery. The panel is physically
# portrait (1200x2000); the stock system rotates it to landscape via
# hwrotation=1. Setting 0 here makes OrangeFox show in portrait.
PRODUCT_PROPERTY_OVERRIDES += \
    ro.sf.hwrotation=0

# TWRP device settings
PRODUCT_PACKAGES += \
    twrp

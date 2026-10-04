# device.mk - YOUXUEPAI P709/U60 (k71v1_64_bsp)
# Recovery-only config. The base product is provided by the product .mk files
# (embedded.mk + vendor/omni/config/common.mk), not here.

# Copy recovery fstab into ramdisk
PRODUCT_COPY_FILES += \
    device/youxuepai/k71v1_64_bsp/twrp.fstab:recovery/root/etc/twrp.fstab \
    device/youxuepai/k71v1_64_bsp/twrp.fstab:recovery/root/etc/recovery.fstab

# TWRP device settings
PRODUCT_PACKAGES += \
    twrp

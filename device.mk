# device.mk - YOUXUEPAI P709/U60 (k71v1_64_bsp)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Product identifiers
PRODUCT_NAME := omni_k71v1_64_bsp
PRODUCT_DEVICE := k71v1_64_bsp
PRODUCT_BRAND := YOUXUEPAI
PRODUCT_MANUFACTURER := YOUXUEPAI
PRODUCT_MODEL := P709
PRODUCT_RELEASE_NAME := P709

# Copy recovery fstab into ramdisk
PRODUCT_COPY_FILES += \
    device/youxuepai/k71v1_64_bsp/twrp.fstab:recovery/root/etc/twrp.fstab \
    device/youxuepai/k71v1_64_bsp/twrp.fstab:recovery/root/etc/recovery.fstab

# TWRP device settings
PRODUCT_PACKAGES += \
    twrp

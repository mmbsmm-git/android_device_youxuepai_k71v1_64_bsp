# omni_k71v1_64_bsp.mk - OrangeFox/TWRP omni lunch product
# Structure modeled on OrangeFox fox_9.0 official device (begonia: omni_begonia.mk)

PRODUCT_RELEASE_NAME := P709

$(call inherit-product, build/target/product/embedded.mk)
$(call inherit-product, vendor/omni/config/common.mk)
$(call inherit-product, device/youxuepai/k71v1_64_bsp/device.mk)

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := k71v1_64_bsp
PRODUCT_NAME := omni_k71v1_64_bsp
PRODUCT_BRAND := YOUXUEPAI
PRODUCT_MODEL := P709
PRODUCT_MANUFACTURER := YOUXUEPAI

# Vendor security patch placeholder (required by the build for recovery)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.build.security_patch=2099-12-31

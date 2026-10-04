# twrp_k71v1_64_bsp.mk - TWRP product (for scripts that lunch twrp_<codename>)

PRODUCT_RELEASE_NAME := P709

$(call inherit-product, build/target/product/embedded.mk)
$(call inherit-product, vendor/omni/config/common.mk)
$(call inherit-product, device/youxuepai/k71v1_64_bsp/device.mk)

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := k71v1_64_bsp
PRODUCT_NAME := twrp_k71v1_64_bsp
PRODUCT_BRAND := YOUXUEPAI
PRODUCT_MODEL := P709
PRODUCT_MANUFACTURER := YOUXUEPAI

PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.build.security_patch=2099-12-31

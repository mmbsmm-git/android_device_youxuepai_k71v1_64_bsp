# 这是针对 TWRP 构建的修改
# 替换原来的 vendor/omni/config/common.mk
$(call inherit-product, build/target/product/embedded.mk)
# 或者如果 TWRP 有特定配置，使用：
# $(call inherit-product, vendor/twrp/config/common.mk)

# 你的设备配置
PRODUCT_DEVICE := k71v1_64_bsp
PRODUCT_NAME := omni_k71v1_64_bsp
PRODUCT_BRAND := youxuepai
PRODUCT_MODEL := k71v1_64_bsp
PRODUCT_MANUFACTURER := youxuepai

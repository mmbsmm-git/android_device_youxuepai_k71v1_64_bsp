# OrangeFox 专用产品配置
# 继承 OrangeFox 通用配置
$(call inherit-product, vendor/fox/config/common.mk)

# 设备信息
PRODUCT_DEVICE := k71v1_64_bsp
PRODUCT_NAME := fox_k71v1_64_bsp
PRODUCT_BRAND := youxuepai
PRODUCT_MODEL := k71v1_64_bsp
PRODUCT_MANUFACTURER := youxuepai

# 启用 OrangeFox 特定功能
FOX_VERSION := R11.1_2
FOX_BUILD_TYPE := Unofficial
FOX_MAINTAINER := YourName
FOX_VARIANT := 12.1
FOX_ARCH := arm64


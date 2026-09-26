#
# Copyright (C) 2026 The Android Open Source Project
# Copyright (C) 2026 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Omni stuff.
$(call inherit-product, vendor/omni/config/common.mk)

# Inherit from k71v1_64_bsp device
$(call inherit-product, device/youxuepai/k71v1_64_bsp/device.mk)

PRODUCT_DEVICE := k71v1_64_bsp
PRODUCT_NAME := omni_k71v1_64_bsp
PRODUCT_BRAND := YOUXUEPAI
PRODUCT_MODEL := P709
PRODUCT_MANUFACTURER := youxuepai

PRODUCT_GMS_CLIENTID_BASE := android-youxuepai

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="full_k71v1_64_bsp-userdebug 9 PPR1.180610.011 eng.releas.20240830.002157 dev-keys"

BUILD_FINGERPRINT := YOUXUEPAI/full_k71v1_64_bsp/k71v1_64_bsp:9/PPR1.180610.011/release08300021:userdebug/dev-keys

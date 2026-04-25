#
# Copyright (C) 2026 The Android Open Source Project
# Copyright (C) 2026 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

PRODUCT_MAKEFILES := \
    $(LOCAL_DIR)/omni_k71v1_64_bsp.mk \
    $(LOCAL_DIR)/fox_k71v1_64_bsp.mk  # 新增 OrangeFox 配置

# 午餐组合
COMMON_LUNCH_CHOICES := \
    omni_k71v1_64_bsp-eng \
    fox_k71v1_64_bsp-eng  # 新增 OrangeFox 组合

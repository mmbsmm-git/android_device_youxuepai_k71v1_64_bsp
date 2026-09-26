# Android device tree for YOUXUEPAI P709 (k71v1_64_bsp)

```
#
# Copyright (C) 2026 The Android Open Source Project
# Copyright (C) 2026 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#
```


## Kernel / Himax note

This tree uses `prebuilt/kernel` and `prebuilt/dtbo.img`. The prebuilt kernel is a gzip-compressed ARM64 4.4.146 kernel with an appended DTB; its kernel image contains the Himax HX83102 touchscreen driver built-in (`CONFIG_TOUCHSCREEN_HIMAX_* = y`), so no Himax `.ko` is required. OrangeFox builds using a prebuilt kernel should export `OF_FORCE_PREBUILT_KERNEL=1`.

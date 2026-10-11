# device.mk - YOUXUEPAI P709/U60 (k71v1_64_bsp)
# Recovery-only config. The base product is provided by the product .mk files
# (embedded.mk + vendor/omni/config/common.mk), not here.

# Copy recovery fstab into ramdisk
PRODUCT_COPY_FILES += \
    device/youxuepai/k71v1_64_bsp/twrp.fstab:recovery/root/etc/twrp.fstab \
    device/youxuepai/k71v1_64_bsp/twrp.fstab:recovery/root/etc/recovery.fstab

# prop.default for recovery.
# 2026-10-11 更正（实测）：本 OFRP 9.0 树里 PRODUCT_PROPERTY_OVERRIDES **确实**会进
# recovery ramdisk 的 prop.default —— 证据：最终 ramdisk 的 prop.default(3415B) 里同时
# 出现了 device.mk 的 ro.sf.hwrotation=0 与 omni_*.mk 的 ro.vendor.build.security_patch=2099-12-31。
# 结论：之前的"静态 prop.default 覆盖"说法不成立（编译系统生成的 prop.default 会覆盖本条 copy），
# 设备属性应走下方 PRODUCT_PROPERTY_OVERRIDES 开关块。静态文件保留仅作参考/兜底。
PRODUCT_COPY_FILES += \
    device/youxuepai/k71v1_64_bsp/recovery/root/prop.default:recovery/root/prop.default

# Custom default font for OrangeFox GUI (RobotoCondensed-Regular, verified to contain
# CJK glyphs so the zh_CN UI renders; user wanted a CJK-capable font for the recovery).
# Overrides TWRP's default RobotoCondensed-Regular.ttf inside the recovery ramdisk's twres.
PRODUCT_COPY_FILES += \
    device/youxuepai/k71v1_64_bsp/recovery/root/twres/fonts/RobotoCondensed-Regular.ttf:recovery/root/twres/fonts/RobotoCondensed-Regular.ttf

# 原厂对齐属性（原厂 rec 的 prop.default 里 treble=true / zygote64_32 / mount.fs=EXT4 /
# platform=mt6771 / lcd_density=320 等；OFRP 默认生成的是 Omni 值：
# treble=false、abilist64 空、完全缺 MTK 属性）。这些经 PRODUCT_PROPERTY_OVERRIDES
# 注入，会落到 recovery ramdisk 的 prop.default（已实测）。
# ro.sf.hwrotation=0：面板物理竖屏 1200x2000，竖屏显示 + 触摸坐标一致（用户要求竖屏）。
PRODUCT_PROPERTY_OVERRIDES += \
    ro.treble.enabled=true \
    ro.zygote=zygote64_32 \
    ro.mount.fs=EXT4 \
    ro.mediatek.platform=MT6771 \
    ro.sf.lcd_density=320 \
    ro.sf.hwrotation=0 \
    persist.sys.usb.config=adb

# TWRP device settings
PRODUCT_PACKAGES += \
    twrp

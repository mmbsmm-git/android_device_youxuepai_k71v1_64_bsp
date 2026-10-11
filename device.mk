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

# 字体：使用 OrangeFox 主题自带字体（原厂字体），不做替换。
# 2026-10-11 结论：曾用自定义 RobotoCondensed-Regular.ttf(2.58MB, JetBrains Maple Mono)
# 覆盖默认字体，导致 slim_rec 为压体积把主题 font.xml 需要的字体
# (Roboto-Regular/Medium、GoogleSans-*、EuclidFlex-* 等 15 个, 共约1.31MB) 全删了
# -> 主题字体资源加载失败(NULL) -> 渲染 SIGSEGV -> init 反复重启(SIGSEGV 循环)。
# 现改为不拷贝任何字体：编译产物自带完整的主题字体(约1.5MB)，slim_rec 不再删字体。

# CRITICAL: OrangeFox theme entry point.
# The recovery binary loads /twres/ui.xml unconditionally (strings in sbin/recovery:
# "/twres/ui.xml", "/twres/splash.xml", "/twres/languages/en.xml"). The 2026-10-11
# build shipped a twres tree with NO ui.xml (also lost /ueventd.rc and the twres/twrp
# dir; only splash.xml survived) -> the binary paints the splash, then the theme load
# fails -> black screen / process exit -> init restarts the (non-oneshot)
# "service recovery" -> splash <-> black loop with backlight on.
# NOTE: 不要把 ui.xml/ueventd.rc 用 PRODUCT_COPY_FILES 拷进 recovery/root，避免与编译
# 系统自己生成的目标同名冲突。改为由 Lazy 仓库 slim_rec.py 在打包阶段注入/校验
# (源文件就放在本目录 recovery/root/twres/ui.xml 与 recovery/root/ueventd.rc)。
# slim_rec.py 会在 twres/ui.xml 缺失时直接 FATAL，防止再产出会 loop 的镜像。

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
    ro.adb.secure=0 \
    persist.sys.usb.config=adb

# TWRP device settings
PRODUCT_PACKAGES += \
    twrp

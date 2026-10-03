# Android device tree for YOUXUEPAI P709 / U60 (k71v1_64_bsp)

MTK MT6771 (Helio P70) tablet, Android 9 (userdebug). TWRP / OrangeFox / PBRP recovery device tree.

## Device info (from stock recovery.bin)

- **Codename**: `k71v1_64_bsp`
- **SoC**: MT6771 (arm64, GPU Mali-G72)
- **Android**: 9
- **Screen**: nt35595 FHD DSI (truly panel + nt50358 driver), landscape tablet
- **Touch**: `cap_touch@5d` (mediatek,cap_touch, i2c 0x5d, 5-point)
- **Kernel**: prebuilt from stock **boot.img** kernel (gzip zImage, contains the touch driver)

## Build

Use a TWRP / OrangeFox / PBRP tree for **Android 9**. Then:

```
source build/envsetup.sh
lunch omni_k71v1_64_bsp-userdebug    # or twrp_/ofox_ alias
mka recoveryimage    # or: mka bootimage, or the script you use
```

The produced image is a full boot-style recovery image (`recovery.img`).
**Note (known community issue):** `fastboot boot recovery.img` does **not** work on this
device (MTK + OrangeFox) - the recovery must be **flashed** to the partition. Flash to
the **recovery** partition:
```
fastboot flash recovery recovery.img
fastboot reboot recovery
```
or from a working recovery:
```
dd if=/recovery.img of=/dev/block/platform/bootdevice/by-name/recovery
```

## Product aliases

| lunch | notes |
|---|---|
| `omni_k71v1_64_bsp-userdebug` | TWRP standard (used by TWRP_OFOX_PBRP_SHRP etc.) |
| `twrp_k71v1_64_bsp-userdebug` | TWRP `twrp_<codename>` scripts |
| `ofox_k71v1_64_bsp-userdebug` | OrangeFox scripts that expect `ofox_<codename>` |

`MAKEFILE_NAME` in the GitHub Action builder should be left matching the alias you pick
(e.g. `omni_k71v1_64_bsp`), or blank to auto-derive from `DEVICE_NAME`.

## Robustness notes

- **Partition sizes are intentionally not hard-coded** for system/vendor/userdata/cache.
  A recovery build does not produce those partition images, so only `BOARD_BOOT/RECOVERYIMAGE_PARTITION_SIZE`
  (64 MB) are set as the mkbootimg pack boundary. Resizing partitions via GPT does **not**
  require touching this device tree. `twrp.fstab` carries no sizes, so mounting works
  regardless of partition size.
- Kernel addresses (base/offset/ramdisk/tags) come from the stock recovery.bin boot header
  and must not be changed.
- `recovery.fstab` is a copy of `twrp.fstab` for compatibility.

## Files

```
Android.mk  AndroidProducts.mk  BoardConfig.mk  device.mk
omni_k71v1_64_bsp.mk  twrp_k71v1_64_bsp.mk  ofox_k71v1_64_bsp.mk
twrp.fstab  recovery.fstab  vendorsetup.sh  README.md
kernel/kernel              # prebuilt gzip zImage from stock boot.img (contains touch driver)
prebuilt/recovery_dtbo.img # stock DTBO overlay (carries the cap_touch node)
recovery/root/init.recovery.mt6771.rc  # MTK recovery init (USB gadget / adbd)
```

## OrangeFox (OFox) support

This device tree is fully OrangeFox-ready. Two ways to build it:

1. **`omni_k71v1_64_bsp-userdebug`** — OrangeFox builds off the omni base, so the `omni_`
   product works directly with the OrangeFox source tree.
2. **`ofox_k71v1_64_bsp-userdebug`** — explicit `ofox_` product if your script lunches `ofox_<codename>`.

OF_ build variables (`OF_TARGET_DEVICE_ABI`, `OF_AB_DEVICE_WITH_RECOVERY`,
`OF_DISABLE_MIUI_SPECIFIC_FEATURES`, `OF_SUPPORT_ALL_BLOCK_OTA_UPDATES`,
`OF_QUICK_BACKUP_LIST`, `OF_TWRP_COMPATIBILITY_MODE`, `OF_USE_MAGISKBOOT_FOR_ALL_PATCHES`,
`OF_FLASHLIGHT_ENABLE`, `OF_USE_TWRP_SAR_DETECT`, `OF_NO_TREBLE_COMPATIBILITY_CHECK`,
`OF_MAINTAINER`, `OF_SCREEN_H`, `OF_DEFAULT_KEYMASTER_VERSION`)
are set in **BoardConfig.mk** where the OrangeFox source expects them.
FOX_ environment vars (`FOX_BUILD_DEVICE`, `OF_FORCE_PREBUILT_KERNEL`,
`OF_DISABLE_MIUI_SPECIFIC_FEATURES`) are exported in **vendorsetup.sh** (per the official
guide: FOX_ vars must not be placed in .mk files).

**Touch:** uses the prebuilt **boot.img kernel** (touch driver compiled in - this is why the
system touchscreen works), plus the stock **DTBO overlay** (`prebuilt/recovery_dtbo.img`,
which carries the `cap_touch@5d` node). Together they make touch work in recovery.
This was chosen after confirming the stock **recovery.bin** kernel lacks the touch driver
(community-confirmed: "Recovery也没有触摸驱动") - using it would leave recovery with no touch.

**Known-issue checklist covered:**
- `fastboot boot` not usable -> flash to partition (see above)
- Stuck on logo / decryption -> `OF_DEFAULT_KEYMASTER_VERSION := 4.0` (Android 9 keymaster)
- `NO KERNEL CONFIG` with prebuilt kernel -> `OF_FORCE_PREBUILT_KERNEL=1` in vendorsetup.sh
- Non-MIUI device -> `OF_DISABLE_MIUI_SPECIFIC_FEATURES=1`
- Image size -> 64 MB partition boundary, kernel ~9.4 MB + ramdisk ~9.5 MB, far below limit

For OrangeFox 9, use the **OrangeFox android-9 / fox_9.0** branch of the OrangeFox source
(https://gitlab.com/OrangeFox).

# vendorsetup.sh - YOUXUEPAI P709 (k71v1_64_bsp)
# OrangeFox build environment (exported per official docs)
export FOX_BUILD_DEVICE=k71v1_64_bsp
export OF_FORCE_PREBUILT_KERNEL=1
export OF_DISABLE_MIUI_SPECIFIC_FEATURES=1

# lunch combos for TWRP / OrangeFox / PBRP
add_lunch_combo omni_k71v1_64_bsp-userdebug
add_lunch_combo omni_k71v1_64_bsp-eng
add_lunch_combo twrp_k71v1_64_bsp-userdebug
add_lunch_combo twrp_k71v1_64_bsp-eng
add_lunch_combo ofox_k71v1_64_bsp-userdebug
add_lunch_combo ofox_k71v1_64_bsp-eng

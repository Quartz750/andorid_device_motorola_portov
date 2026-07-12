#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/motorola/portov

# A/B
AB_OTA_PARTITIONS += \
    boot \
    dtbo \
    init_boot \
    product \
    recovery \
    system \
    system_dlkm \
    system_ext \
    vbmeta \
    vbmeta_system \
    vendor \
    vendor_boot \
    vendor_dlkm

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-2a-dotprod
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := kryo300

# Audio
AUDIO_FEATURE_ENABLED_DLKM := true
AUDIO_FEATURE_ENABLED_EXTENDED_COMPRESS_FORMAT := true
AUDIO_FEATURE_ENABLED_GKI := true
AUDIO_FEATURE_ENABLED_INSTANCE_ID := true
AUDIO_FEATURE_ENABLED_MCS := true
AUDIO_FEATURE_ENABLED_SVA_MULTI_STAGE := true
BOARD_SUPPORTS_OPENSOURCE_STHAL := true
BOARD_SUPPORTS_SOUND_TRIGGER := true
BOARD_USES_ALSA_AUDIO := true
TARGET_PROVIDES_AUDIO_HAL := true
TARGET_PROVIDES_LIBAR_PAL := true

# Audio (Dolby)
AUDIO_FEATURE_ENABLED_DS2_DOLBY_DAP := true

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := parrot

# Broken
BUILD_BROKEN_MISSING_REQUIRED_MODULES := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true

# Display
TARGET_SCREEN_DENSITY := 390

# Filesystem
TARGET_FS_CONFIG_GEN := $(DEVICE_PATH)/configs/config.fs

# FM
TARGET_HAS_FM := true

# DTB / DTBO
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_USES_QCOM_MERGE_DTBS_SCRIPT := true
TARGET_NEEDS_DTBOIMAGE := true
TARGET_MERGE_DTBS_WILDCARD ?= parrot*base

# Init Boot
BOARD_INIT_BOOT_HEADER_VERSION := 4
BOARD_MKBOOTIMG_INIT_ARGS += --header_version $(BOARD_INIT_BOOT_HEADER_VERSION)

# Boot
BOARD_USES_GENERIC_KERNEL_IMAGE := true
BOARD_BOOT_HEADER_VERSION := 4
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)

# Kernel
BOARD_KERNEL_CMDLINE += \
    console=ttynull \
    nosoftlockup \
    printk.devkmsg=on \
    firmware_class.path=/vendor/firmware_mnt/image \
    qcom_geni_serial.con_enabled=0 \
    sysctl.kernel.firmware_config.force_sysfs_fallback=1

BOARD_BOOTCONFIG += \
    androidboot.hardware=qcom \
    androidboot.load_modules_parallel=true \
    androidboot.memcg=1 \
    androidboot.usbcontroller=a600000.dwc3 \
    androidboot.hypervisor.protected_vm.supported=true \
    androidboot.vendor.qspa=true

BOARD_RAMDISK_USE_LZ4 := true
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_USES_GENERIC_KERNEL_IMAGE := true
BOARD_KERNEL_IMAGE_NAME := Image
BOARD_MOVE_GSI_AVB_KEYS_TO_VENDOR_BOOT := true

BOARD_KERNEL_CMDLINE := androidboot.hardware=qcom androidboot.memcg=1 androidboot.usbcontroller=a600000.dwc3 androidboot.load_modules_parallel=true
BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive

BOARD_SYSTEM_KERNEL_MODULES := $(wildcard $(DEVICE_PATH)-kernel/system_dlkm/*.ko)
BOARD_SYSTEM_KERNEL_MODULES_LOAD := $(patsubst %,$(DEVICE_PATH)-kernel/vendor_dlkm/%,$(shell cat $(DEVICE_PATH)-kernel/system_dlkm/modules.load))
BOARD_VENDOR_KERNEL_MODULES := $(wildcard $(DEVICE_PATH)-kernel/vendor_dlkm/*.ko)
BOARD_VENDOR_KERNEL_MODULES_LOAD := $(patsubst %,$(DEVICE_PATH)-kernel/vendor_dlkm/%,$(shell cat $(DEVICE_PATH)-kernel/vendor_dlkm/modules.load))
BOARD_VENDOR_RAMDISK_KERNEL_MODULES := $(wildcard $(DEVICE_PATH)-kernel/vendor_ramdisk/*.ko)
BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD := $(patsubst %,$(DEVICE_PATH)-kernel/vendor_dlkm/%,$(shell cat $(DEVICE_PATH)-kernel/vendor_ramdisk/modules.load))
BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD := $(patsubst %,$(DEVICE_PATH)-kernel/vendor_dlkm/%,$(shell cat $(DEVICE_PATH)-kernel/vendor_ramdisk/modules.load.recovery))
BOOT_KERNEL_MODULES := $(BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD) $(BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD)

BOARD_MKBOOTIMG_ARGS := --header_version $(BOARD_BOOT_HEADER_VERSION)

# Prebuilt Kernel
TARGET_KERNEL_CONFIG := portov
INLINE_KERNEL_BUILDING := true
TARGET_FORCE_PREBUILT_KERNEL := true
TARGET_NO_KERNEL_OVERRIDE := true
TARGET_NO_KERNEL := false
BOARD_KERNEL_BINARIES := kernel
TARGET_KERNEL_VERSION := 6.6
TARGET_KERNEL_SOURCE := $(DEVICE_PATH)-kernel/kernel-headers
TARGET_PREBUILT_DTB := $(DEVICE_PATH)-kernel/dtb.img
BOARD_PREBUILT_DTBOIMAGE := $(DEVICE_PATH)-kernel/dtbo.img
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)-kernel/kernel
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)-kernel/dtb.img:$(TARGET_COPY_OUT)/dtb.img \
    $(DEVICE_PATH)-kernel/kernel:kernel


# Metadata
BOARD_USES_METADATA_PARTITION := true

# Partitions
-include vendor/lineage/config/BoardConfigReservedSize.mk
BOARD_BUILD_VENDOR_RAMDISK_IMAGE := true

BOARD_FLASH_BLOCK_SIZE := 131072 # (BOARD_KERNEL_PAGESIZE * 32)
BOARD_BOOTIMAGE_PARTITION_SIZE := 100663296
BOARD_DTBOIMG_PARTITION_SIZE := 25165824
BOARD_INIT_BOOT_IMAGE_PARTITION_SIZE := 8388608
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 134217728
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 100663296

BOARD_SUPER_PARTITION_SIZE := 8589934592
BOARD_SUPER_PARTITION_GROUPS := mot_dp_group
BOARD_MOT_DP_GROUP_SIZE := 8585740288 # (BOARD_SUPER_PARTITION_SIZE - 4MB)
BOARD_MOT_DP_GROUP_PARTITION_LIST := product system system_dlkm system_ext vendor vendor_dlkm

$(foreach p, $(call to-upper, $(BOARD_MOT_DP_GROUP_PARTITION_LIST)), \
    $(eval BOARD_$(p)IMAGE_FILE_SYSTEM_TYPE := ext4) \
    $(eval TARGET_COPY_OUT_$(p) := $(call to-lower, $(p))))

# HWUI
HWUI_COMPILE_FOR_PERF := true

# Platform
BOARD_USES_QCOM_HARDWARE := true
TARGET_BOARD_PLATFORM := parrot

# Security
BOOT_SECURITY_PATCH := 2026-04-01
VENDOR_SECURITY_PATCH := $(BOOT_SECURITY_PATCH)

# Properties
TARGET_ODM_PROP += $(DEVICE_PATH)/configs/props/odm.prop
TARGET_PRODUCT_PROP += $(DEVICE_PATH)/configs/props/product.prop
TARGET_SYSTEM_EXT_PROP += $(DEVICE_PATH)/configs/props/system_ext.prop
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/configs/props/system.prop
TARGET_VENDOR_PROP += $(DEVICE_PATH)/configs/props/vendor.prop

# Recovery
BOARD_EXCLUDE_KERNEL_FROM_RECOVERY_IMAGE := true
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/init/fstab.qcom
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

# SEPolicy
include device/lineage/sepolicy/libperfmgr/sepolicy.mk
include device/qcom/sepolicy_vndr/SEPolicy.mk
include hardware/motorola/sepolicy/qti/SEPolicy.mk
BOARD_VENDOR_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy/vendor

# RIL
ENABLE_VENDOR_RIL_SERVICE := true

# Manifest
ODM_MANIFEST_SKUS += b d dn dne n ne
ODM_MANIFEST_B_FILES := $(DEVICE_PATH)/vintf/sku/manifest_b.xml
ODM_MANIFEST_D_FILES := $(DEVICE_PATH)/vintf/sku/manifest_d.xml
ODM_MANIFEST_DN_FILES := $(DEVICE_PATH)/vintf/sku/manifest_dn.xml
ODM_MANIFEST_DNE_FILES := $(DEVICE_PATH)/vintf/sku/manifest_dne.xml
ODM_MANIFEST_N_FILES := $(DEVICE_PATH)/vintf/sku/manifest_n.xml
ODM_MANIFEST_NE_FILES := $(DEVICE_PATH)/vintf/sku/manifest_ne.xml

PRODUCT_ENFORCE_VINTF_MANIFEST := true
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE += \
    hardware/qcom-caf/common/vendor_framework_compatibility_matrix.xml \
    hardware/motorola/vintf/device_framework_matrix.xml \
    $(DEVICE_PATH)/vintf/compatibility_matrix.device.xml

DEVICE_MATRIX_FILE := hardware/qcom-caf/common/compatibility_matrix_aidl.xml
DEVICE_MANIFEST_FILE := \
    $(DEVICE_PATH)/vintf/manifest.xml \
    hardware/qcom-caf/sm8450-6.6/audio/primary-hal/configs/common/manifest_non_qmaa.xml \
    hardware/qcom-caf/sm8450-6.6/audio/primary-hal/configs/common/manifest_non_qmaa_extn.xml

# Verified Boot
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3
BOARD_AVB_ROLLBACK_INDEX := 22
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := 22
BOARD_AVB_VBMETA_SYSTEM := system system_ext product
BOARD_AVB_VBMETA_SYSTEM_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_VBMETA_SYSTEM_ALGORITHM := SHA256_RSA2048
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX_LOCATION := 2
BOARD_MOVE_GSI_AVB_KEYS_TO_VENDOR_BOOT := true

# WiFi
BOARD_WLAN_DEVICE := qcwcn
BOARD_HOSTAPD_DRIVER := NL80211
BOARD_HOSTAPD_PRIVATE_LIB := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
BOARD_WPA_SUPPLICANT_PRIVATE_LIB_EVENT := "ON"
WIFI_DRIVER_STATE_CTRL_PARAM := "/dev/wlan"
WIFI_DRIVER_STATE_OFF := "OFF"
WIFI_DRIVER_STATE_ON := "ON"
WIFI_FEATURE_HOSTAPD_11AX := true
WIFI_HIDL_FEATURE_AWARE := true
WIFI_HIDL_FEATURE_DUAL_INTERFACE := true
WIFI_HIDL_UNIFIED_SUPPLICANT_SERVICE_RC_ENTRY := true
WPA_SUPPLICANT_VERSION := VER_0_8_X

# Include the proprietary files BoardConfig.
include vendor/motorola/portov/BoardConfigVendor.mk

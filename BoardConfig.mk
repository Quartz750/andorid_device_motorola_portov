#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/motorola/portov
KERNEL_PATH := $(DEVICE_PATH)-kernel

# Inherit from motorola sm6450-common
include device/motorola/sm6450-common/BoardConfigCommon.mk

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := portov

# Kernel
BOARD_KERNEL_CMDLINE += \
    printk.devkmsg=on \
    firmware_class.path=/vendor/firmware_mnt/image \
    androidboot.selinux=permissive \
    sysctl.kernel.firmware_config.force_sysfs_fallback=1

BOARD_BOOTCONFIG := \
    androidboot.hardware=qcom \
    androidboot.hypervisor.protected_vm.supported=true \
    androidboot.load_modules_parallel=true \
    androidboot.memcg=1 \
    androidboot.usbcontroller=a600000.dwc3 \
    androidboot.vendor.qspa=true

BOARD_USES_GENERIC_KERNEL_IMAGE := true
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_PAGESIZE := 4096
BOARD_KERNEL_IMAGE_NAME := Image

# Prebuilt kernel
BOARD_KERNEL_TAGS_OFFSET := 0x01E00000
BOARD_RAMDISK_OFFSET     := 0x02000000

TARGET_KERNEL_SOURCE := $(KERNEL_PATH)/kernel-headers
TARGET_KERNEL_VERSION := 6.6
TARGET_NO_KERNEL_OVERRIDE := true

PRODUCT_COPY_FILES += \
    $(KERNEL_PATH)/kernel:kernel

# Kernel modules
DLKM_MODULES_PATH := $(KERNEL_PATH)/vendor_dlkm
RAMDISK_MODULES_PATH := $(KERNEL_PATH)/vendor_ramdisk
SYSTEM_DLKM_MODULES_PATH := $(KERNEL_PATH)/system_dlkm

BOARD_SYSTEM_KERNEL_MODULES := $(wildcard $(SYSTEM_DLKM_MODULES_PATH)/*.ko)
BOARD_SYSTEM_KERNEL_MODULES_LOAD := $(patsubst %,$(SYSTEM_DLKM_MODULES_PATH)/%,$(shell cat $(SYSTEM_DLKM_MODULES_PATH)/modules.load))
BOARD_VENDOR_KERNEL_MODULES := $(wildcard $(DLKM_MODULES_PATH)/*.ko)
BOARD_VENDOR_KERNEL_MODULES_LOAD := $(patsubst %,$(DLKM_MODULES_PATH)/%,$(shell cat $(DLKM_MODULES_PATH)/modules.load))
BOARD_VENDOR_KERNEL_MODULES_BLOCKLIST_FILE := $(DLKM_MODULES_PATH)/modules.blocklist

BOARD_VENDOR_RAMDISK_KERNEL_MODULES := $(wildcard $(RAMDISK_MODULES_PATH)/*.ko)
BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD := $(patsubst %,$(RAMDISK_MODULES_PATH)/%,$(shell cat $(RAMDISK_MODULES_PATH)/modules.load))
BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD  := $(patsubst %,$(RAMDISK_MODULES_PATH)/%,$(shell cat $(RAMDISK_MODULES_PATH)/modules.load.recovery))
BOARD_VENDOR_RAMDISK_KERNEL_MODULES_BLOCKLIST_FILE := $(RAMDISK_MODULES_PATH)/modules.blocklist

# Partitions
BOARD_MOT_DP_GROUP_SIZE := 7511998464 # (BOARD_SUPER_PARTITION_SIZE - 4MB)
BOARD_SUPER_PARTITION_SIZE := 7516192768

# Properties
TARGET_PRODUCT_PROP += $(DEVICE_PATH)/configs/properties/product.prop
TARGET_VENDOR_PROP += $(DEVICE_PATH)/configs/properties/vendor.prop

# Recovery
TARGET_RECOVERY_UI_MARGIN_HEIGHT := 90

# Security
BOOT_SECURITY_PATCH := 2026-08-01
VENDOR_SECURITY_PATCH := $(BOOT_SECURITY_PATCH)

# Vintf
ODM_MANIFEST_SKUS += d dn dne
ODM_MANIFEST_D_FILES := $(DEVICE_PATH)/configs/vintf/sku/manifest_d.xml
ODM_MANIFEST_DN_FILES := $(DEVICE_PATH)/configs/vintf/sku/manifest_dn.xml
ODM_MANIFEST_DNE_FILES := $(DEVICE_PATH)/configs/vintf/sku/manifest_dne.xml

DEVICE_PRODUCT_COMPATIBILITY_MATRIX_FILE := $(DEVICE_PATH)/configs/vintf/compatibility_matrix_device.xml

# Verified Boot
BOARD_AVB_ROLLBACK_INDEX := 11
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := 11

# inherit from the proprietary version
include vendor/motorola/portov/BoardConfigVendor.mk

# nasty build error:
# $(shell mkdir -p ../../../out/target/product/fx3q/obj/SHARED_LIBRARIES/libqdutils_intermediates/)
# $(shell touch ../../../out/target/product/fx3q/obj/SHARED_LIBRARIES/libqdutils_intermediates/import_includes)
# $(shell touch ./out/target/product/fx3q/obj/SHARED_LIBRARIES/libqdutils_intermediates/export_includes)

# fx3q HAL libraries
BOARD_HAL_STATIC_LIBRARIES := \
    libhealthd.fx3q

# Inherit from the proprietary version
-include vendor/lge/fx3q/BoardConfigVendor.mk

TARGET_BOARD_INFO_FILE := device/lge/fx3q/board-info.txt

BOARD_VENDOR := LGE
TARGET_NO_BOOTLOADER := true
TARGET_BOARD_PLATFORM := msm8960
TARGET_CPU_VARIANT := krait
TARGET_ARCH := arm
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_SMP := true
COMMON_GLOBAL_CFLAGS += -D__ARM_USE_PLD -D__ARM_CACHE_LINE_SIZE=64
TARGET_GLOBAL_CFLAGS += -mfpu=neon-vfpv4 -mfloat-abi=softfp
TARGET_GLOBAL_CPPFLAGS += -mfpu=neon-vfpv4 -mfloat-abi=softfp
BOARD_USES_QCOM_HARDWARE := true
TARGET_USES_QCOM_BSP := true
COMMON_GLOBAL_CFLAGS += -DQCOM_HARDWARE -DQCOM_BSP

# Kernel
BOARD_CUSTOM_BOOTIMG_MK      := device/lge/fx3q/releasetools/mkbootimg.mk
#BOARD_KERNEL_CMDLINE         := androidboot.hardware=qcom user_debug=31 zcache
BOARD_KERNEL_CMDLINE         := CMDLINE WILL BE IGNORED BY sediKERNEL. SO YOU NEED TO CHANGE KERNEL WHEN YOU WANT OTHER BOOT ARGS. xdajog.
BOARD_KERNEL_BASE            := 0x80200000
BOARD_MKBOOTIMG_ARGS         := --ramdisk_offset 0x02000000
BOARD_KERNEL_PAGESIZE        := 2048
TARGET_SPECIFIC_HEADER_PATH := device/lge/fx3q/include
TARGET_NO_INITLOGO := true

# Kernel build options either prebuilt:
#TARGET_PREBUILT_KERNEL := device/lge/fx3q/sediKERNEL
# ... or as recommended by CM - path to the sources and config:
TARGET_KERNEL_SOURCE := kernel/lge/fx3q
TARGET_PRODUCT=sediROM_fx3q
TARGET_KERNEL_CONFIG := fx3q_xdajog_defconfig
# Use GCC 4.6 to compile the kernel as recommended by LG:
ARM_EABI_TOOLCHAIN :=/home/hannu/arm-eabi-4.6/bin

# this will disable init.rc build and using LGE ones instead
TARGET_PROVIDES_INIT_RC := true

# Krait optimizations
ARCH_ARM_HAVE_NEON := true
TARGET_USE_KRAIT_BIONIC_OPTIMIZATION := true
TARGET_USE_KRAIT_PLD_SET := true
TARGET_KRAIT_BIONIC_PLDOFFS := 10
TARGET_KRAIT_BIONIC_PLDTHRESH := 10
TARGET_KRAIT_BIONIC_BBTHRESH := 64
TARGET_KRAIT_BIONIC_PLDSIZE := 64

# MPDECISION
TARGET_MPDECISION_BOOST_SOCKET := /dev/socket/mpdecision/touchboost

# Hardware tunables framework
BOARD_HARDWARE_CLASS := device/lge/fx3q/cmhw/

#######################################################################
# TWRP
#
DEVICE_RESOLUTION := 480x800
TARGET_USERIMAGES_USE_F2FS := false
# This was driving me nuts and at the end it is so easy.. the support for /data/media
RECOVERY_SDCARD_ON_DATA := true
BOARD_HAS_NO_REAL_SDCARD := true
TW_INTERNAL_STORAGE_PATH := "/data/media"
TW_INTERNAL_STORAGE_MOUNT_POINT := "data"
# Support for device encryption in TWRP (JB or higher)
#TW_INCLUDE_CRYPTO := true
TW_INCLUDE_JB_CRYPTO := true
TW_CRYPTO_REAL_BLKDEV := "/dev/block/platform/msm_sdcc.1/by-name/userdata"
TW_CRYPTO_MNT_POINT := "/data"
TW_CRYPTO_FS_OPTIONS := "nosuid,nodev,barrier=1,noauto_da_alloc,discard"
TW_CRYPTO_FS_FLAGS := "0x00000406"
TW_CRYPTO_KEY_LOC := "footer"
# removes the reboot bootloader button from the reboot menu cause we have no fastboot
TW_NO_REBOOT_BOOTLOADER := true
# defaults to external storage instead of internal on dual storage devices
TW_DEFAULT_EXTERNAL_STORAGE := true
BOARD_HAS_LARGE_FILESYSTEM := true
TW_ALWAYS_RMRF := true
#
# TWRP END
#######################################################################

# Recovery
BOARD_USES_MMCUTILS := true
BOARD_HAS_NO_MISC_PARTITION := true
#TARGET_RECOVERY_FSTAB := device/lge/fx3q/ramdisk/fstab.qcom
TARGET_RECOVERY_FSTAB := device/lge/fx3q/twrp_min.fstab
TARGET_RECOVERY_INITRC := device/lge/fx3q/recovery/root/init.recovery.rc
TARGET_RECOVERY_LCD_BACKLIGHT_PATH := \"/sys/class/lcd/panel/backlight\"
COMMON_GLOBAL_CFLAGS += -DNO_SECURE_DISCARD
TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"
TARGET_USERIMAGES_USE_EXT4 := true
BOARD_BOOTIMAGE_PARTITION_SIZE := 12582912
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 12582912
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 1291845632
BOARD_USERDATAIMAGE_PARTITION_SIZE := 1384120320
BOARD_CACHEIMAGE_PARTITION_SIZE := 838860800
BOARD_FLASH_BLOCK_SIZE := 131072
BOARD_HAS_NO_SELECT_BUTTON := true
BOARD_RECOVERY_SWIPE := true

# Graphics
TARGET_QCOM_DISPLAY_VARIANT := legacy
TARGET_BOARD_PLATFORM_GPU := qcom-adreno305
USE_OPENGL_RENDERER := true
TARGET_USES_OVERLAY := true
BOARD_USES_HWCOMPOSER := true
TARGET_USES_SF_BYPASS := true
TARGET_USES_C2D_COMPOSITION := true
TARGET_USES_ION := true
TARGET_DISPLAY_INSECURE_MM_HEAP := true
BOARD_EGL_CFG := vendor/lge/fx3q/proprietary/lib/egl/egl.cfg

# Lights
TARGET_PROVIDES_LIBLIGHT := true

# Audio
TARGET_QCOM_AUDIO_VARIANT := legacy
BOARD_USES_ALSA_AUDIO := true
#BOARD_USES_LEGACY_ALSA_AUDIO := true
TARGET_USES_QCOM_COMPRESSED_AUDIO := true

# Media
TARGET_ENABLE_QC_AV_ENHANCEMENTS := true
#TARGET_QCOM_MEDIA_VARIANT := caf
TARGET_QCOM_MEDIA_VARIANT := legacy
TARGET_DISPLAY_USE_RETIRE_FENCE := false

# Camera
USE_DEVICE_SPECIFIC_CAMERA := true
TARGET_PROVIDES_CAMERA_HAL := true
TARGET_PROVIDES_LIBCAMERA := true
COMMON_GLOBAL_CFLAGS += -DLGF6_CAMERA_HARDWARE

# Wifi
BOARD_WLAN_DEVICE 		:= bcmdhd
BOARD_WLAN_DEVICE_REV 		:= bcm4330
WIFI_DRIVER_FW_PATH_PARAM 	:= "/sys/module/bcmdhd/parameters/firmware_path"
WIFI_DRIVER_FW_PATH_STA 	:= "/system/etc/firmware/fw_bcmdhd.bin"
WIFI_DRIVER_FW_PATH_AP 		:= "/system/etc/firmware/fw_bcmdhd_apsta.bin"
WIFI_DRIVER_FW_PATH_P2P 	:= "/system/etc/firmware/fw_bcmdhd_p2p.bin"
WIFI_BAND 			:= 802_11_ABGN
BOARD_WPA_SUPPLICANT_DRIVER 	:= NL80211
BOARD_HOSTAPD_DRIVER 		:= NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
BOARD_HOSTAPD_PRIVATE_LIB 	:= lib_driver_cmd_$(BOARD_WLAN_DEVICE)
WPA_SUPPLICANT_VERSION 		:= VER_0_8_X


# BLUETOOTH 
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_BCM := true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/lge/fx3q/bluetooth
BOARD_BLUEDROID_VENDOR_CONF := device/lge/fx3q/bluetooth/libbt_vndcfg.txt

# GPS
BOARD_HAVE_NEW_QC_GPS := true

# FM
QCOM_FM_ENABLED := true
BOARD_USES_SEPERATED_FM := true

# NFC
BOARD_HAVE_NFC := true
#BOARD_NFC_HAL_SUFFIX := default

# Time services
BOARD_USES_QC_TIME_SERVICES := true

# PowerHAL
POWERHAL_EXTENSION := fx3q
TARGET_POWERHAL_TOUCH_BOOST := true

# https://groups.google.com/forum/#!topic/cyanogenmod-dev/7GnJqmARVRQ
# Use CM PowerHAL by default
TARGET_POWERHAL_VARIANT := cm

# Charger
BOARD_CHARGING_MODE_BOOTING_LPM := /sys/class/power_supply/battery/batt_lp_charging
BOARD_BATTERY_DEVICE_NAME := "battery"
BOARD_CHARGER_ENABLE_SUSPEND := true
BOARD_CHARGER_RES := device/lge/fx3q/ramdisk/res/images/charger

# Vold
BOARD_VOLD_MAX_PARTITIONS := 24
TARGET_USE_CUSTOM_LUN_FILE_PATH := /sys/devices/platform/msm_hsusb/gadget/lun%d/file

# Releasetools
TARGET_PROVIDES_RELEASETOOLS := true
TARGET_RELEASETOOL_OTA_FROM_TARGET_SCRIPT := ./device/lge/fx3q/releasetools/ota_from_target_files

# Assert
TARGET_OTA_ASSERT_DEVICE := F3Q,D520,fx3q

# Vibrator
#BOARD_HAS_VIBRATOR_IMPLEMENTATION := ../../device/lge/fx3q/vibrator/tspdrv.c

# Web
WEBRTC_BUILD_NEON_LIBS := true

BOARD_SEPOLICY_DIRS := \
       device/lge/fx3q/sepolicy

BOARD_SEPOLICY_UNION := \
       app.te \
       bluetooth.te \
       device.te \
       domain.te \
       drmserver.te \
       file.te \
       file_contexts \
       hci_init.te \
       init_shell.te \
       keystore.te \
       mediaserver.te \
       kickstart.te \
       nfc.te \
       rild.te \
       surfaceflinger.te \
       system.te \
       ueventd.te \
       wpa.te



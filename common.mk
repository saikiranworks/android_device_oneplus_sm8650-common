#
# Copyright (C) 2021-2026 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# A/B
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/vabc_features.mk)

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_vendor=true \
    POSTINSTALL_PATH_vendor=bin/checkpoint_gc \
    FILESYSTEM_TYPE_vendor=erofs \
    POSTINSTALL_OPTIONAL_vendor=true

# Anti-rollback check on the new slot's xbl_config before it can be booted
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_odm=true \
    POSTINSTALL_PATH_odm=bin/xbl_config_arb_check \
    FILESYSTEM_TYPE_odm=erofs \
    POSTINSTALL_OPTIONAL_odm=false

PRODUCT_PACKAGES += \
    checkpoint_gc \
    otapreopt_script \
    xbl_config_arb_check

PRODUCT_VIRTUAL_AB_COMPRESSION_METHOD := lz4

# Audio
PRODUCT_PACKAGES += \
    android.hardware.audio@7.1-impl \
    android.hardware.audio.effect@7.0-impl \
    android.hardware.audio.service \
    android.hardware.soundtrigger@2.3-impl \
    audio.r_submix.default \
    audio.usb.default \
    libagm_compress_plugin \
    libagm_mixer_plugin \
    libagm_pcm_plugin \
    libaudiochargerlistener \
    libbatterylistener \
    libcustomva_intf \
    libfmpal \
    libhfp_pal \
    libhotword_intf \
    libqcompostprocbundle \
    libqcomvisualizer \
    libqcomvoiceprocessing \
    libvolumelistener \
    sound_trigger.primary.pineapple

AUDIO_HAL_DIR := vendor/qcom/opensource/audio-hal/primary-hal
CONFIG_HAL_SRC_DIR := $(AUDIO_HAL_DIR)/configs/pineapple
CONFIG_PAL_SRC_DIR := $(AUDIO_HAL_DIR)/../../pal/configs/pineapple
QCV_FAMILY_SKUS := pineapple cliffs

PRODUCT_COPY_FILES += \
$(foreach DEVICE_SKU, $(QCV_FAMILY_SKUS), \
    $(CONFIG_HAL_SRC_DIR)/audio_effects.conf:$(TARGET_COPY_OUT_VENDOR)/etc/audio/sku_$(DEVICE_SKU)/audio_effects.conf \
    $(LOCAL_PATH)/configs/audio/audio_effects.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio/sku_$(DEVICE_SKU)/audio_effects.xml \
    $(LOCAL_PATH)/configs/audio/audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio/sku_$(DEVICE_SKU)/audio_policy_configuration.xml)

PRODUCT_COPY_FILES += \
    $(AUDIO_HAL_DIR)/configs/common/audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_configuration.xml \
    $(CONFIG_PAL_SRC_DIR)/card-defs.xml:$(TARGET_COPY_OUT_VENDOR)/etc/card-defs.xml \
    $(CONFIG_PAL_SRC_DIR)/Hapticsconfig.xml:$(TARGET_COPY_OUT_VENDOR)/etc/Hapticsconfig.xml \
    $(CONFIG_HAL_SRC_DIR)/microphone_characteristics.xml:$(TARGET_COPY_OUT_VENDOR)/etc/microphone_characteristics.xml \
    $(CONFIG_PAL_SRC_DIR)/usecaseKvManager.xml:$(TARGET_COPY_OUT_VENDOR)/etc/usecaseKvManager.xml

PRODUCT_COPY_FILES += \
    frameworks/av/services/audiopolicy/config/r_submix_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/r_submix_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/usb_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/usb_audio_policy_configuration.xml \
    frameworks/native/data/etc/android.hardware.audio.low_latency.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.audio.low_latency.xml \
    frameworks/native/data/etc/android.hardware.audio.pro.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.audio.pro.xml \
    frameworks/native/data/etc/android.software.midi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.midi.xml

$(call soong_config_set_bool,android_hardware_audio,skip_speaker_layout_channel_mask_field,true)

# Bluetooth
PRODUCT_PACKAGES += \
    lib_bt_aptx \
    lib_bt_ble \
    lib_bt_bundle

# Boot control
PRODUCT_PACKAGES += \
    android.hardware.boot-service.qti \
    android.hardware.boot-service.qti.recovery

# Camera
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.camera.concurrent.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.concurrent.xml \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.camera.full.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.full.xml \
    frameworks/native/data/etc/android.hardware.camera.raw.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.raw.xml

# Context Hub
ifneq ($(TARGET_IS_TABLET),true)
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.context_hub.xml:$(TARGET_COPY_OUT_ODM)/etc/permissions/android.hardware.context_hub.xml
endif

# Dalvik
$(call inherit-product, frameworks/native/build/phone-xhdpi-6144-dalvik-heap.mk)

# DebugFS
PRODUCT_SET_DEBUGFS_RESTRICTIONS := true

# Display
PRODUCT_PACKAGES += \
    android.hardware.graphics.mapper@4.0-impl-qti-display \
    init.qti.display_boot.rc \
    init.qti.display_boot.sh \
    libgpu_tonemapper \
    vendor.qti.hardware.display.allocator-service \
    vendor.qti.hardware.display.composer-service \
    vendor.qti.hardware.display.composer3-V1-ndk.vendor \
    vendor.qti.hardware.display.config-V2-ndk.vendor \
    vendor.qti.hardware.display.demura-service \
    vendor.qti.hardware.display.demura-V1-ndk.vendor

# Dolby
$(call inherit-product, vendor/oneplus/dolby/config.mk)

# DRM
PRODUCT_PACKAGES += \
    android.hardware.drm-service.clearkey

# Enforce generic ramdisk allow list
$(call inherit-product, $(SRC_TARGET_DIR)/product/generic_ramdisk.mk)

# Fastboot
PRODUCT_PACKAGES += \
    android.hardware.fastboot-service.example_recovery \
    fastbootd

# Fingerprint
ifneq ($(TARGET_IS_TABLET),true)
PRODUCT_PACKAGES += \
    IFAAService

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.fingerprint.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.fingerprint.xml

$(call soong_config_set,surfaceflinger,udfps_lib,//hardware/oplus:libudfps_extension.oplus)
endif

# Health
PRODUCT_PACKAGES += \
    android.hardware.health-service.qti \
    android.hardware.health-service.qti_recovery

# Hotword enrollment
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/permissions/privapp-permissions-hotword.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/privapp-permissions-hotword.xml

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init/fstab.qcom:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.qcom

# Init
PRODUCT_PACKAGES += \
    fstab.qcom \
    init.aospa.rc \
    init.class_main.sh \
    init.kernel.post_boot.sh \
    init.kernel.post_boot-cliffs_default_3_4_1.sh \
    init.kernel.post_boot-pineapple.sh \
    init.kernel.post_boot-pineapple_default_2_3_2_1.sh \
    init.oplus.rc \
    init.qcom.early_boot.sh \
    init.qcom.post_boot.sh \
    init.qcom.rc \
    init.qcom.recovery.rc \
    init.qcom.sh \
    init.qti.kernel.rc \
    init.target.rc \
    ueventd.oplus.rc \
    ueventd.qcom.rc

$(call soong_config_set,libinit,vendor_init_lib,//$(LOCAL_PATH):libinit_oplus)

# IPACM
ifneq ($(TARGET_IS_TABLET),true)
PRODUCT_PACKAGES += \
    ipacm \
    IPACM_cfg.xml \
    IPACM_Filter_cfg.xml
endif

# IR
ifneq ($(TARGET_IS_TABLET),true)
PRODUCT_PACKAGES += \
    android.hardware.ir-service.oplus

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.consumerir.xml:$(TARGET_COPY_OUT_ODM)/etc/permissions/android.hardware.consumerir.xml
endif

# Kernel
PRODUCT_ENABLE_UFFD_GC := true

PRODUCT_COPY_FILES += \
    kernel/oneplus/sm8650/modules.systemdlkm_blocklist.msm.pineapple:$(TARGET_COPY_OUT_VENDOR_DLKM)/lib/modules/system_dlkm.modules.blocklist

# Keymint
PRODUCT_PACKAGES += \
    android.hardware.hardware_keystore_V3.xml

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.keystore.app_attest_key.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.keystore.app_attest_key.xml \
    frameworks/native/data/etc/android.software.device_id_attestation.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.device_id_attestation.xml

# Lineage Health
PRODUCT_PACKAGES += \
    vendor.lineage.health-service.default

$(call soong_config_set,lineage_health,charging_control_charging_path,/sys/class/oplus_chg/battery/mmi_charging_enable)

# Media
$(call inherit-product-if-exists, hardware/qcom/media/product.mk)

PRODUCT_COPY_FILES += \
    $(AUDIO_HAL_DIR)/configs/common/codec2/media_codecs_c2_audio.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_c2_audio.xml \
    $(AUDIO_HAL_DIR)/configs/common/codec2/service/1.0/c2audio.vendor.base-arm64.policy:$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy/c2audio.vendor.base-arm64.policy \
    $(AUDIO_HAL_DIR)/configs/common/codec2/service/1.0/c2audio.vendor.ext-arm64.policy:$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy/c2audio.vendor.ext-arm64.policy

# Memtrack
PRODUCT_PACKAGES += \
    vendor.qti.hardware.memtrack-service

# NFC
ifneq ($(TARGET_IS_TABLET),true)
PRODUCT_PACKAGES += \
    android.hardware.nfc-service.nxp \
    com.android.nfc_extras \
    Tag

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.nfc.ese.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.ese.xml \
    frameworks/native/data/etc/android.hardware.nfc.hce.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.hce.xml \
    frameworks/native/data/etc/android.hardware.nfc.hcef.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.hcef.xml \
    frameworks/native/data/etc/android.hardware.nfc.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.xml \
    frameworks/native/data/etc/android.hardware.se.omapi.ese.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.se.omapi.ese.xml \
    frameworks/native/data/etc/android.hardware.se.omapi.uicc.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.se.omapi.uicc.xml \
    frameworks/native/data/etc/com.android.nfc_extras.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/com.android.nfc_extras.xml \
    frameworks/native/data/etc/com.nxp.mifare.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/com.nxp.mifare.xml
endif

# OPlus dummy services
PRODUCT_PACKAGES += \
    vendor.oplus.hardware.commondcs-service \
    vendor.oplus.hardware.osense.client-service \
    vendor.oplus.hardware.performance-service

# Oplus IR
$(call inherit-product, vendor/oneplus/ir/config.mk)

# Overlays
$(call inherit-product, hardware/oplus/overlay/overlay.mk)

PRODUCT_ENFORCE_RRO_TARGETS := *
PRODUCT_PACKAGES += \
    FrameworksResTargetCommon \
    OPlusFrameworksResCommon \
    OPlusSettingsResCommon \
    OPlusSystemUIResCommon \
    WifiResTarget

ifneq ($(TARGET_IS_TABLET),true)
PRODUCT_PACKAGES += \
    CarrierConfigResCommon \
    FrameworksResTargetPhone
endif

# Partitions
PRODUCT_PACKAGES += \
    vendor_bt_firmware_mountpoint \
    vendor_dsp_mountpoint \
    vendor_firmware_mnt_mountpoint

PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Platform
TARGET_BOARD_PLATFORM := pineapple

# QTI components
TARGET_COMMON_QTI_COMPONENTS := \
    adreno \
    alarm \
    audio \
    av \
    bt \
    display \
    gps \
    overlay \
    perf \
    usb \
    wfd \
    wlan

# Wifi-only tablets have no modem
ifneq ($(TARGET_IS_TABLET),true)
TARGET_COMMON_QTI_COMPONENTS += telephony
endif

# QSPA
PRODUCT_PACKAGES += \
    qspa_vendor.rc \
    vendor.qti.qspa-service

# SMMU
TARGET_USES_SMMU_PROXY := true

# SecureElement
ifneq ($(TARGET_IS_TABLET),true)
PRODUCT_PACKAGES += \
    SecureElementResTarget_Vendor

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/permissions/com.android.se.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/com.android.se.xml
endif

# Sensors
PRODUCT_PACKAGES += \
    android.hardware.sensors-service.oplus-multihal \
    sensors.dynamic_sensor_hal \
    sensors.oplus \
    sensors.wrapper

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.ambient_temperature.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.ambient_temperature.xml \
    frameworks/native/data/etc/android.hardware.sensor.barometer.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.barometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.dynamic.head_tracker.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.dynamic.head_tracker.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.hifi_sensors.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.hifi_sensors.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.relative_humidity.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.relative_humidity.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepcounter.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.stepcounter.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepdetector.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.stepdetector.xml

ifneq ($(TARGET_IS_TABLET),true)
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.proximity.xml
endif

$(call soong_config_set,oplus_sensors,uses_tap_sensor,true)
$(call soong_config_set,oplus_sensors,uses_double_tap_sensor,true)

# Shipping API
BOARD_SHIPPING_API_LEVEL := 34
PRODUCT_SHIPPING_API_LEVEL += $(BOARD_SHIPPING_API_LEVEL)

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH) \
    hardware/oplus

# Storage
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Telephony
ifneq ($(TARGET_IS_TABLET),true)
PRODUCT_PACKAGES += \
    nrmodeswitcher \

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.telephony.cdma.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.telephony.cdma.xml \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/native/data/etc/android.hardware.telephony.ims.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.telephony.ims.xml \
    frameworks/native/data/etc/android.hardware.telephony.mbms.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.telephony.mbms.xml

$(call inherit-product, hardware/oplus/oplus-fwk/oplus-fwk.mk)
endif

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.sip.voip.xml

# Thermal
PRODUCT_PACKAGES += \
    android.hardware.thermal-service.qti

# Update engine
PRODUCT_PACKAGES += \
    update_engine \
    update_engine_sideload \
    update_verifier

PRODUCT_PACKAGES_DEBUG += \
    update_engine_client

# USB
PRODUCT_PACKAGES += \
    oplus_usb_compositions.conf

# Verified Boot
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.verified_boot.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.verified_boot.xml

# Vibrator
ifneq ($(TARGET_IS_TABLET),true)
PRODUCT_COPY_FILES += \
    vendor/qcom/opensource/vibrator/excluded-input-devices.xml:$(TARGET_COPY_OUT_VENDOR)/etc/excluded-input-devices.xml
endif

# VINTF
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE += \
    hardware/oplus/vintf/device_framework_matrix.xml
DEVICE_MANIFEST_FILE := \
    $(AUDIO_HAL_DIR)/configs/common/manifest_non_qmaa.xml \
    $(AUDIO_HAL_DIR)/configs/common/manifest_non_qmaa_extn.xml \
    $(LOCAL_PATH)/vintf/manifest_pineapple.xml

ifneq ($(TARGET_IS_TABLET),true)
DEVICE_MANIFEST_FILE += \
    $(LOCAL_PATH)/vintf/network_manifest.xml

ODM_MANIFEST_FILES := \
    $(LOCAL_PATH)/vintf/network_manifest_odm.xml
endif

# Virtualization service
$(call inherit-product, packages/modules/Virtualization/apex/product_packages.mk)

# WiFi firmware symlinks
PRODUCT_PACKAGES += \
    firmware_wlanmdsp.otaupdate_symlink

# Inherit from the proprietary files makefile.
$(call inherit-product, vendor/oneplus/sm8650-common/sm8650-common-vendor.mk)

# Tablet: caihong-tuned task profiles
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/profiles/task_profiles.json:$(TARGET_COPY_OUT_VENDOR)/etc/task_profiles.json

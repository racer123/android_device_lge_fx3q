
# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_phone.mk)

$(call inherit-product, device/lge/fx3q/fx3q.mk)

#PRODUCT_BUILD_PROP_OVERRIDES +=
# Release name
PRODUCT_RELEASE_NAME := fx3q

PRODUCT_DEVICE := fx3q
PRODUCT_NAME := cm_fx3q
PRODUCT_BRAND := LGE
PRODUCT_MANUFACTURER := lge
PRODUCT_MODEL := F3Q

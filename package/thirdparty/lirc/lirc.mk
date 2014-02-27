LIRC_VERSION = 0.9.0
LIRC_SOURCE = lirc-$(LIRC_VERSION).tar.gz
LIRC_SITE = http://downloads.sourceforge.net/project/lirc/LIRC/$(LIRC_VERSION)
LIRC_INSTALL_STAGING = YES
LIRC_INSTALL_TARGET = YES
LIRC_DEPENDENCIES = linux
LIRC_MAKE=$(MAKE1)

LIRC_CONF_OPT += --with-kerneldir=$(LINUX_DIR)
LIRC_CONF_OPT += --with-driver=none

# hack to avoid mknod (requires root). This will be populated automatically.
LIRC_CONF_OPT += ac_cv_path_mknod=$(shell which echo)

# disable X support
LIRC_CONF_OPT += --without-x

ifeq ($(BR2_TOOLCHAIN_EXTERNAL),y)
LIRC_MAKE_ENV += PATH=$(TOOLCHAIN_EXTERNAL_DIR)/bin:$(TARGET_PATH) CROSS_COMPILE=$(TOOLCHAIN_EXTERNAL_PREFIX)-
LIRC_CONF_ENV += PATH=$(TOOLCHAIN_EXTERNAL_DIR)/bin:$(TARGET_PATH) CROSS_COMPILE=$(TOOLCHAIN_EXTERNAL_PREFIX)- LIBUSB_CONFIG=$(STAGING_DIR)/usr/bin/libusb-config
else
LIRC_MAKE_ENV += PATH=$(TOOLCHAIN_DIR)/bin:$(TARGET_PATH)
LIRC_CONF_ENV += PATH=$(TOOLCHAIN_DIR)/bin:$(TARGET_PATH)
endif

#work-around for hard-coded depmod
define LIRC_DEPMOD
$(HOST_DIR)/sbin/depmod -b $(TARGET_DIR) -a $(LINUX_VERSION_PROBED)
endef

define LIRC_INSTALL_ETC
  cp -rf package/thirdparty/lirc/etc $(TARGET_DIR)
endef

LIRC_POST_INSTALL_TARGET_HOOKS += LIRC_DEPMOD
LIRC_POST_INSTALL_TARGET_HOOKS += LIRC_INSTALL_ETC

$(eval $(autotools-package))

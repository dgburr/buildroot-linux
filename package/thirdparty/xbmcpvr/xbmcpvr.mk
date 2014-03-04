XBMCPVR_VERSION = f809707735518651a10c5dec6f6bb7ab789cc65d
XBMCPVR_SITE = git://github.com/fetzerch/xbmc-pvr-addons.git
XBMCPVR_AUTORECONF = YES
XBMCPVR_INSTALL_STAGING = YES
XBMCPVR_INSTALL_TARGET = YES

XBMCPVR_CONF_ENV += MYSQL_CONFIG=$(TARGET_DIR)/usr/bin/mysql_config
XBMCPVR_CONF_OPT += --enable-addons-with-dependencies

$(eval $(autotools-package))

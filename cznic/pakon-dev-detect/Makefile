#
# Copyright (C) 2017 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=pakon-dev-detect
PKG_VERSION:=1.2.1
PKG_RELEASE:=3
PKG_LICENSE:=GPLv2+
PKG_LICENSE_FILES:=COPYING

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/pakon-dev-detect.git
PKG_SOURCE_VERSION:=e16a2391494597b79aa675a57c55ca50039e8740
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
MAINTAINER:=Martin Petracek <martin.petracek@nic.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python3-package.mk)

define Package/pakon-dev-detect
  TITLE:=pakon-dev-detect
  DEPENDS:=+python3-light +python3-logging +python3-setuptools +suricata +ouidb
endef

define Package/pakon-dev-detect/description
 This package provides a utility to detect new devices on LAN (using suricata).
endef

define Build/Compile
	$(call Build/Compile/Py3Mod,,install --prefix=/usr --root=$(PKG_INSTALL_DIR) --single-version-externally-managed)
endef

define Py3Package/pakon-dev-detect/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(CP) $(PKG_INSTALL_DIR)/usr/bin/* $(1)/usr/bin

	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/pakon-dev-detect.init $(1)/etc/init.d/pakon-dev-detect

	$(INSTALL_DIR) $(1)/etc/suricata/output_conf.d
	$(INSTALL_BIN) ./files/output_dev_detect.yaml $(1)/etc/suricata/output_conf.d/dev_detect.yaml

	$(INSTALL_DIR) $(1)/usr/share/pakon-dev-detect
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/get_mac_iface.sh $(1)/usr/share/pakon-dev-detect/
endef

define Package/pakon-dev-detect/postinst
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || {
        /etc/init.d/suricata restart
	/etc/init.d/pakon-dev-detect enable
	/etc/init.d/pakon-dev-detect start
}
endef

define Package/pakon-dev-detect/prerm
#!/bin/sh
	/etc/init.d/pakon-dev-detect disable
	/etc/init.d/pakon-dev-detect stop
endef

define Package/pakon-dev-detect/postrm
#!/bin/sh
        /etc/init.d/suricata restart || true
endef

$(eval $(call Py3Package,pakon-dev-detect))
$(eval $(call BuildPackage,pakon-dev-detect))

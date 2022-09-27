#
## Copyright (C) 2020-2022 CZ.NIC z.s.p.o. (https://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=turris-survey
PKG_VERSION:=0.4
PKG_RELEASE:=$(AUTORELEASE)

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/sentinel/turris-survey.git
PKG_MIRROR_HASH:=ac6cf838afc5cd78d430c138cd9f76abffb5072232ce3770ca77233e7c11c2fe
PKG_SOURCE_VERSION:=v$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-3.0-or-later
PKG_LICENSE_FILES:=LICENSE.txt

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

define Package/turris-survey
  SECTION:=collect
  CATEGORY:=Collect
  SUBMENU:=Sentinel
  TITLE:=Turris Survey
  URL:=https://gitlab.nic.cz/turris/sentinel/turris-survey
  DEPENDS:=+python3-light +python3-msgpack +python3-zmq +sentinel-proxy +updater-supervisor +cronie
endef

define Package/turris-survey/description
  Periodically collects Turris OS usage information - OS version, list of
  installed packages and package lists.
endef

define Py3Package/turris-survey/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(CP) $(PKG_INSTALL_DIR)/usr/bin/* $(1)/usr/bin/

	$(INSTALL_DIR) $(1)/etc/cron.d
	$(INSTALL_CONF) ./files/crond $(1)/etc/cron.d/turris-survey

	$(INSTALL_DIR) $(1)/usr/libexec/sentinel/status.d
	$(INSTALL_BIN) ./files/sentinel-status.sh $(1)/usr/libexec/sentinel/status.d/22-turris-survey.sh
endef

$(eval $(call Py3Package,turris-survey))
$(eval $(call BuildPackage,turris-survey))
$(eval $(call BuildPackage,turris-survey-src))

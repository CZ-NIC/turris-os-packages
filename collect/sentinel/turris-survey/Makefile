#
## Copyright (C) 2020 CZ.NIC z.s.p.o. (https://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=turris-survey
PKG_VERSION:=0.1.1
PKG_RELEASE:=5

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/sentinel/turris-survey.git
PKG_MIRROR_HASH:=5bbb43ef3c43807dbfc9c058fc6537c1a289fc54363ec6d16cfd0e3adcfc1fbb
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
  VARIANT:=python3
endef

define Package/turris-survey/description
  Periodically collect router statistics like usage, installed software.
endef

define Py3Package/turris-survey/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(CP) $(PKG_INSTALL_DIR)/usr/bin/* $(1)/usr/bin/

	$(INSTALL_DIR) $(1)/etc/cron.d
	$(INSTALL_CONF) ./files/crond $(1)/etc/cron.d/turris-survey
endef

$(eval $(call Py3Package,turris-survey))
$(eval $(call BuildPackage,turris-survey))
$(eval $(call BuildPackage,turris-survey-src))

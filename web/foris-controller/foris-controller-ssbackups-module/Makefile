#
# Copyright (C) 2018-2019 CZ.NIC z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=foris-controller-ssbackups-module
PKG_VERSION:=0.5.1
PKG_RELEASE:=4

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/foris-controller/foris-controller-ssbackups-module.git
PKG_SOURCE_VERSION:=v$(PKG_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-3.0-or-later
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk
include ../foris-controller/files/foris-controller-module.mk

define Package/foris-controller-ssbackups-module
  TITLE:=Foris controller ssbackups module
  DEPENDS:=
    +foris-controller \
    +ssbackups \
    +python3-pbkdf2
  VARIANT:=python3
endef

define Package/foris-controller-ssbackups-module/description
  This is a ssbackups module for foris-controller.
endef

define Package/foris-controller-ssbackups-module/conffiles
/etc/config/ssbackups
endef

define ForisControllerModule/foris-controller-ssbackups-module/install
	$(INSTALL_DIR) $(1)/etc/cron.d $(1)/etc/config $(1)/usr/libexec
	$(INSTALL_DATA) ./files/ssbackups.cron $(1)/etc/cron.d/ssbackups
	$(INSTALL_CONF) ./files/ssbackups.uci $(1)/etc/config/ssbackups
	$(INSTALL_BIN) ./files/ssbackups.sh $(1)/usr/libexec/ssbackups.sh
endef

$(eval $(call ForisControllerModule,foris-controller-ssbackups-module))
# call BuildPackage <= assures OWR build system that this is package

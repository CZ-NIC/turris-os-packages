#
## Copyright (C) 2019 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#
#
include $(TOPDIR)/rules.mk


PKG_NAME:=mox-otp
PKG_VERSION:=0.2.1
PKG_RELEASE:=1
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/mox-otp.git
PKG_SOURCE_VERSION:=v$(PKG_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

define Package/$(PKG_NAME)
	TITLE:=MOX OTP CLI
	URL:=https://gitlab.labs.nic.cz/turris/mox-otp
	PROVIDES:=turris-otp
	DEPENDS:=+python3-light
	VARIANT=python3
endef

define Package/$(PKG_NAME)/description
	Command line tool to query MOX CPU read-only OTP device
endef

define Py3Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/mox-otp $(1)/usr/bin/mox-otp
endef

$(eval $(call Py3Package,$(PKG_NAME)))
$(eval $(call BuildPackage,$(PKG_NAME)))
$(eval $(call BuildPackage,$(PKG_NAME)-src))

#
## Copyright (C) 2020 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=python3-python
PKG_VERSION:=1.0.0
PKG_RELEASE:=1
PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/python3-python
  TITLE:=Python3 python link
  DEPENDS:=+python3-base
  CONFLICTS:=python-base
endef

define Package/python3-python/description
  This package provides python link to python3. 
endef

define Package/python3-python/install
	$(INSTALL_DIR) $(1)/usr/bin
	ln -s /usr/bin/python3 $(1)/usr/bin/python
endef

Build/Compile:=:

$(eval $(call BuildPackage,python3-python))

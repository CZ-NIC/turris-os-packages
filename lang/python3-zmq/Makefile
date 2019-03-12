#
# Copyright (C) 2017 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python3-zmq
PKG_VERSION:=16.0.2
PKG_RELEASE:=2

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=git://github.com/zeromq/pyzmq.git
PKG_SOURCE_VERSION:=v$(PKG_VERSION)
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)
PKG_BUILD_DEPENDS:=cython

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python3-package.mk)

define Package/$(PKG_NAME)
  SUBMENU:=Python
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=python3-zmq
  URL:=http://walac.github.io/pyusb/
  DEPENDS:=+python3 +libzmq
  MAINTAINER:=CZ.NIC <packaging@turris.cz>
endef

define Package/$(PKG_NAME)/description
  Python binding to ZeroMQ
endef

define Build/Compile
	$(call Build/Compile/Py3Mod,,install --prefix="/usr" --root=$(PKG_INSTALL_DIR) --zmq=$(STAGING_DIR)/usr)
endef

$(eval $(call Py3Package,python3-zmq))
$(eval $(call BuildPackage,python3-zmq))

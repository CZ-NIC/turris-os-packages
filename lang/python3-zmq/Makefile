#
# Copyright (C) 2017 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python3-zmq
PKG_VERSION:=17.1.2
PKG_RELEASE:=2

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/zeromq/pyzmq/archive
PKG_SOURCE_VERSION:=v$(PKG_VERSION)
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE:=$(PKG_SOURCE_VERSION).tar.gz
PKG_HASH:=77a32350440e321466b1748e6063b34a8a73768b62cb674e7d799fbc654b7c45

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)
PKG_BUILD_DEPENDS:=cython

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

PKG_UNPACK:=$(HOST_TAR) -C $(PKG_BUILD_DIR) --strip-components=1 -xzf $(DL_DIR)/$(PKG_SOURCE)

define Package/$(PKG_NAME)
  SUBMENU:=Python
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=python3-zmq
  URL:=https://github.com/zeromq/pyzmq
  DEPENDS:=+python3 +libzmq
  MAINTAINER:=CZ.NIC <packaging@turris.cz>
  VARIANT:=python3
endef

define Package/$(PKG_NAME)/description
  Python binding to ZeroMQ
endef

define Build/Compile
	$(call Build/Compile/Py3Mod,,install --prefix="/usr" --root=$(PKG_INSTALL_DIR) --zmq=$(STAGING_DIR)/usr)
endef

$(eval $(call Py3Package,python3-zmq))
$(eval $(call BuildPackage,python3-zmq))

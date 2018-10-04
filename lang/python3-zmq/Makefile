#
# Copyright (C) 2017 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python3-zmq
PKG_VERSION:=17.1.2
PKG_RELEASE:=1

PKG_SOURCE:=pyzmq-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://pypi.python.org/packages/source/p/pyzmq/
PKG_HASH:=a72b82ac1910f2cf61a49139f4974f994984475f771b0faa730839607eeedddf

PKG_BUILD_DIR:=$(BUILD_DIR)/$(BUILD_VARIANT)-pyzmq-$(PKG_VERSION)
PKG_BUILD_DEPENDS:=python3 cython3

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

define prepare_pyzmq_setup
	$(CP) ./files/setup.cfg $(PKG_BUILD_DIR)/setup.cfg
endef

Hooks/Compile/Pre += prepare_pyzmq_setup

define Package/$(PKG_NAME)/description
  Python binding to ZeroMQ
endef

define Build/Compile
	$(call Build/Compile/Py3Mod,,install --prefix="/usr" --root=$(PKG_INSTALL_DIR) --zmq=$(STAGING_DIR)/usr)
endef

$(eval $(call Py3Package,python3-zmq))
$(eval $(call BuildPackage,python3-zmq))

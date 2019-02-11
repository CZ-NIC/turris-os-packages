#
# Copyright (C) 2018-2019 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python-uci
PKG_VERSION:=0.4.1
PKG_RELEASE:=2
PKG_LICENSE:=GPLv3

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/pyuci.git
PKG_SOURCE_VERSION:=v$(PKG_VERSION)
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz

PKG_BUILD_DIR:=$(BUILD_DIR)/$(BUILD_VARIANT)-uci-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python-package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

PKG_UNPACK:=$(HOST_TAR) -C $(PKG_BUILD_DIR) --strip-components=1 -xzf $(DL_DIR)/$(PKG_SOURCE)

define Package/$(PKG_NAME)/Default
  SECTION:=lang-python
  CATEGORY:=Languages
  SUBMENU:=Python
  URL:=https://gitlab.labs.nic.cz/turris/pyuci/
  MAINTAINER:=CZ.NIC <packaging@turris.cz>
endef

define Package/python-uci
$(call Package/$(PKG_NAME)/Default)
  TITLE:=python-uci
  DEPENDS:=+python-light +libuci
  VARIANT:=python
endef

define Package/python3-uci
$(call Package/$(PKG_NAME)/Default)
  TITLE:=python3-uci
  DEPENDS:=+python3-light +libuci
  VARIANT:=python3
endef

define Package/python-uci/description
Python bindings for Unified Configuration Interface.
endef

define Package/python3-uci/description
$(call Package/python-uci/description)
.
(Variant for Python3)
endef

$(eval $(call PyPackage,python-uci))
$(eval $(call BuildPackage,python-uci))
$(eval $(call Py3Package,python3-uci))
$(eval $(call BuildPackage,python3-uci))

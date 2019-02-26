#
# Copyright (C) 2019 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python-cachetools
PKG_VERSION:=3.1.0
PKG_RELEASE:=1
PKG_LICENSE:=MIT

PKG_SOURCE_URL:=https://github.com/tkem/cachetools/archive/
PKG_HASH:=9863c750b563850db89c73332b8f7b92ec8de03050daf396b84d89b48fb009e3
PKG_SOURCE:=v$(PKG_VERSION).tar.gz

PKG_BUILD_DIR:=$(BUILD_DIR)/$(BUILD_VARIANT)-cachetools-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python-package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

PKG_UNPACK:=tar -C $(PKG_BUILD_DIR) --strip-components=1 -xzf $(DL_DIR)/$(PKG_SOURCE)

define Package/$(PKG_NAME)/Default
  SUBMENU:=Python
  SECTION:=lang
  CATEGORY:=Languages
  MAINTAINER:=Thomas Kemmer
  TITLE:=Extensible memoizing collections and decorators
  URL:=https://pypi.python.org/pypi/cachetools
endef

define Package/python-cachetools
$(call Package/$(PKG_NAME)/Default)
  TITLE+= Python2
  DEPENDS:=+python-light
  VARIANT:=python
endef

define Package/python3-cachetools
$(call Package/$(PKG_NAME)/Default)
  TITLE+= Python3
  DEPENDS:=+python3-light
  VARIANT:=python3
endef

define Package/python-cachetools/description
  Extensible memoizing collections and decorators
endef

define Package/python3-cachetools/description
$(call Package/python-cachetools/description)
.
(Variant for Python3)
endef

$(eval $(call PyPackage,python-cachetools))
$(eval $(call BuildPackage,python-cachetools))
$(eval $(call BuildPackage,python-cachetools-src))
$(eval $(call Py3Package,python3-cachetools))
$(eval $(call BuildPackage,python3-cachetools))
$(eval $(call BuildPackage,python3-cachetools-src))

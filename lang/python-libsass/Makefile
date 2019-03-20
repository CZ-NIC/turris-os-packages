#
# Copyright (C) 2018-2019 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python-libsass
PKG_VERSION:=0.18.0
PKG_RELEASE:=1

PKG_SOURCE:=libsass-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://files.pythonhosted.org/packages/source/l/libsass/
PKG_HASH:=c2f386677514f9fc758631328bd318dd3e9d839ad7b6e248ec4535a191bfd271

PKG_BUILD_DIR:=$(BUILD_DIR)/$(BUILD_VARIANT)-libsass-$(PKG_VERSION)
HOST_BUILD_DIR:=$(BUILD_DIR_HOST)/$(BUILD_VARIANT)-libsass-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python-package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

PKG_UNPACK:=$(HOST_TAR) -C $(PKG_BUILD_DIR) --strip-components=1 -xzf $(DL_DIR)/$(PKG_SOURCE)

define Package/python-libsass/Default
  SUBMENU:=Python
  SECTION:=lang
  CATEGORY:=Languages
  URL:=https://github.com/sass/libsass-python
  MAINTAINER:=CZ.NIC <packaging@turris.cz>
  DEPENDS:=+libstdcpp
endef

define Package/python-libsass
  $(call Package/python-libsass/Default)
  TITLE:=python-libsass
  DEPENDS+=+python-light
  VARIANT:=python
endef

define Package/python3-libsass
  $(call Package/python-libsass/Default)
  TITLE:=python3-libsass
  DEPENDS+=+python3-light
  VARIANT:=python3
endef

define Package/python-libsass/description
  A straightforward binding of libsass for Python.
endef

define Package/python3-libsass/description
  $(call Package/python-libsass/description)
  .
  (Variant for Python3)
endef


$(eval $(call PyPackage,python-libsass))
$(eval $(call BuildPackage,python-libsass))
$(eval $(call BuildPackage,python-libsass-src))

$(eval $(call Py3Package,python3-libsass))
$(eval $(call BuildPackage,python3-libsass))
$(eval $(call BuildPackage,python3-libsass-src))

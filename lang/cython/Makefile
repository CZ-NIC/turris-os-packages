include $(TOPDIR)/rules.mk

PKG_NAME:=cython
PKG_VERSION:=0.29.23
PKG_RELEASE:=1

PYPI_NAME:=Cython
PKG_HASH:=6a0d31452f0245daacb14c979c77e093eb1a546c760816b5eed0047686baad8e

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=Apache-2.0
PKG_LICENSE_FILES:=LICENSE.txt

include $(TOPDIR)/feeds/packages/lang/python/pypi.mk
include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

define Package/cython
  SUBMENU:=Python
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=Cython compiler for writing C extensions for Python
  URL:=https://www.cython.org/
  DEPENDS:=+python3
  VARIANT:=python3
endef

define Package/cython/description
  Cython is a language that should make writing C extensions for the Python language easier
endef

$(eval $(call Py3Package,cython))
$(eval $(call BuildPackage,cython))
$(eval $(call BuildPackage,cython-src))

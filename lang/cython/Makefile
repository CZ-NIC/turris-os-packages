include $(TOPDIR)/rules.mk

PKG_NAME:=cython
PKG_VERSION:=0.29.10
PKG_RELEASE:=1

PKG_SOURCE:=Cython-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://files.pythonhosted.org/packages/source/C/Cython/
PKG_HASH:=26229570d6787ff3caa932fe9d802960f51a89239b990d275ae845405ce43857

PKG_BUILD_DIR:=$(BUILD_DIR)/Cython-$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=Apache-2.0
PKG_LICENSE_FILES:=LICENSE.txt

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

define Package/cython3
  SUBMENU:=Python
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=Cython compiler for writing C extensions for Python
  URL:=https://cython.org/
  DEPENDS:=+python3
endef

define Package/cython3/description
  Cython is a language that should make writing C extensions for the Python language easier
endef

$(eval $(call Py3Package,cython3))
$(eval $(call BuildPackage,cython3))
$(eval $(call BuildPackage,cython3-src))

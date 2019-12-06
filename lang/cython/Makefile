include $(TOPDIR)/rules.mk

PKG_NAME:=cython
PKG_VERSION:=0.29.14
PKG_RELEASE:=1

PKG_SOURCE:=Cython-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://files.pythonhosted.org/packages/source/C/Cython/
PKG_HASH:=e4d6bb8703d0319eb04b7319b12ea41580df44fd84d83ccda13ea463c6801414
PKG_BUILD_DIR:=$(BUILD_DIR)/Cython-$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=Apache-2.0
PKG_LICENSE_FILES:=LICENSE.txt

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

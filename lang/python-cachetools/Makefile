include $(TOPDIR)/rules.mk

PKG_NAME:=python-cachetools
PKG_VERSION:=2.0.1
PKG_RELEASE:=1
PKG_LICENSE:=MIT

PKG_SOURCE_URL:=https://github.com/tkem/cachetools/archive/
PKG_MD5SUM:=b559f0ff7e2707e777e59a9cc50eec72
PKG_SOURCE:=v$(PKG_VERSION).tar.gz
PKG_BUILD_DEPENDS:=python-light python-setuptools
PKG_BUILD_DIR:=$(BUILD_DIR)/cachetools-p2-$(PKG_VERSION)
PKG_UNPACK:=tar -C $(PKG_BUILD_DIR) --strip-components=1 -xzf $(DL_DIR)/$(PKG_SOURCE)

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python-package.mk

define Package/$(PKG_NAME)
  SUBMENU:=Python
  SECTION:=lang
  CATEGORY:=Languages
  MAINTAINER:=Thomas Kemmer
  TITLE:=Extensible memoizing collections and decorators
  URL:=https://pypi.python.org/pypi/cachetools
  DEPENDS:=+python3-light
endef

define Package/$(PKG_NAME)/description
  Extensible memoizing collections and decorators
endef

define Build/Compile
  $(call Build/Compile/PyMod,,install --prefix="/usr" --root="$(PKG_INSTALL_DIR)")
endef

$(eval $(call PyPackage,python-cachetools))
$(eval $(call BuildPackage,python-cachetools))

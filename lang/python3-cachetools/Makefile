include $(TOPDIR)/rules.mk

PKG_NAME:=python3-cachetools
PKG_VERSION:=2.0.1
PKG_RELEASE:=2
PKG_LICENSE:=MIT

PKG_SOURCE_URL:=https://github.com/tkem/cachetools/archive/
PKG_MD5SUM:=b559f0ff7e2707e777e59a9cc50eec72
PKG_SOURCE:=v$(PKG_VERSION).tar.gz
PKG_BUILD_DIR:=$(BUILD_DIR)/cachetools-$(PKG_VERSION)
PKG_BUILD_DEPENDS:=python3-light python3-setuptools

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python3-package.mk)

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
  $(call Build/Compile/Py3Mod,,install --prefix="/usr" --root="$(PKG_INSTALL_DIR)")
endef

$(eval $(call Py3Package,python3-cachetools))
$(eval $(call BuildPackage,python3-cachetools))

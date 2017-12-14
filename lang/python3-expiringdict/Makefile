include $(TOPDIR)/rules.mk

PKG_NAME:=python3-expiringdict
PKG_VERSION:=1.1.4
PKG_RELEASE:=1
PKG_LICENSE:=Apache

PKG_SOURCE_URL:=https://github.com/mailgun/expiringdict/archive/
PKG_MD5SUM:=d6ca23a8876a986f29b3006724601119
PKG_SOURCE:=v$(PKG_VERSION).tar.gz
PKG_BUILD_DIR:=$(BUILD_DIR)/expiringdict-$(PKG_VERSION)
PKG_BUILD_DEPENDS:=python3-light python3-setuptools

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python3-package.mk)

define Package/$(PKG_NAME)
  SUBMENU:=Python
  SECTION:=lang
  CATEGORY:=Languages
  MAINTAINER:=Anton Efimenko
  TITLE:= Dictionary with auto-expiring values for caching purposes for Python
  URL:=https://pypi.python.org/pypi/expiringdict/
  DEPENDS:=+python3-light
endef

define Package/$(PKG_NAME)/description
  Dictionary with auto-expiring values for caching purposes for Python
endef

define Build/Compile
  $(call Build/Compile/Py3Mod,,install --prefix="/usr" --root="$(PKG_INSTALL_DIR)")
endef

$(eval $(call Py3Package,python3-expiringdict))
$(eval $(call BuildPackage,python3-expiringdict))

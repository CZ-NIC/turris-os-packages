include $(TOPDIR)/rules.mk

PKG_NAME:=python3-simplejson
PKG_VERSION:=3.10.0
PKG_RELEASE:=2
PKG_LICENSE:=MIT

PKG_SOURCE:=simplejson-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://pypi.python.org/packages/source/s/simplejson/
PKG_MD5SUM:=426a9631d22851a7a970b1a677368b15
PKG_BUILD_DIR:=$(BUILD_DIR)/simplejson-$(PKG_VERSION)
PKG_BUILD_DEPENDS:=python3 python3-setuptools

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python3-package.mk)

define Package/python3-simplejson
  SUBMENU:=Python
  SECTION:=lang
  CATEGORY:=Languages
  MAINTAINER:=Gergely Kiss <mail.gery@gmail.com>
  TITLE:=Simple, fast, extensible JSON encoder/decoder for Python
  URL:=http://simplejson.readthedocs.org/
  DEPENDS:=+python3
endef

define Package/python3-simplejson/description
  Simple, fast, extensible JSON encoder/decoder for Python
endef

define Build/Compile
  $(call Build/Compile/Py3Mod,,install --prefix="/usr" --root="$(PKG_INSTALL_DIR)")
endef

$(eval $(call Py3Package,python3-simplejson))
$(eval $(call BuildPackage,python3-simplejson))

include $(TOPDIR)/rules.mk

PKG_NAME:=python3-urllib3
PKG_VERSION:=1.25.2
PKG_RELEASE:=1

PKG_SOURCE:=urllib3-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://files.pythonhosted.org/packages/source/u/urllib3
PKG_HASH:=a53063d8b9210a7bdec15e7b272776b9d42b2fd6816401a0d43006ad2f9902db

PKG_BUILD_DIR:=$(BUILD_DIR)/urllib3-$(PKG_VERSION)
PKG_BUILD_DEPENDS:=python3-setuptools

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python3-package.mk)

define Package/python3-urllib3
  SUBMENU:=Python
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=HTTP library with thread-safe connection pooling, file post, and more.
  URL:=https://urllib3.readthedocs.io/
endef

define Package/python3-urllib3/description
  Python HTTP for Humans.
endef

define Build/Compile
	$(call Build/Compile/Py3Mod,, \
		install --root="$(PKG_INSTALL_DIR)" --prefix="/usr"  \
		--single-version-externally-managed \
	)
endef

$(eval $(call Py3Package,python3-urllib3))
$(eval $(call BuildPackage,python3-urllib3))

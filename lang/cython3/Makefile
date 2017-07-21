include $(TOPDIR)/rules.mk

PKG_NAME:=cython3
PKG_VERSION:=0.25.2
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://github.com/cython/cython/archive
PKG_BUILD_DIR:=$(BUILD_DIR)/cython-$(PKG_VERSION)
PKG_MD5SUM:=212d50002f72bcdd928f036a46b3ae09

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python3-package.mk)

define Package/cython3
  SUBMENU:=Python
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=cython3
  URL:=http://www.cython.org
  DEPENDS:=+python3
endef

define Package/cython3/description
  Cython is a language that should make writing C extensions for the Python language easier
endef

define Build/Compile
	$(call Build/Compile/Py3Mod,,install --no-cython-compile --prefix="/usr" --root=$(PKG_INSTALL_DIR))
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)$(PYTHON_PKG_DIR)
	$(CP) \
		$(PKG_INSTALL_DIR)$(PYTHON_PKG_DIR)/* \
		$(1)$(PYTHON_PKG_DIR)
endef

$(eval $(call Py3Package,cython3))
$(eval $(call BuildPackage,cython3))

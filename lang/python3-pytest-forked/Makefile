include $(TOPDIR)/rules.mk

PKG_NAME:=python3-pytest-forked
PKG_RELEASE:=1
PKG_VERSION:=1.0.1

PKG_SOURCE_URL:=https://files.pythonhosted.org/packages/26/87/f29282b43dd9c0207d977bd5d65ebd8d2f4e9622c62c0ee4cc763cda4e76/
PKG_HASH:=260d03fbd38d5ce41a657759e8d19bc7c8cfa6d0dcfa36c0bc9742d33bc30742
PKG_SOURCE:=pytest-forked-$(PKG_VERSION).tar.gz

PKG_MAINTAINER:=Jan Pavlinec <jan.pavlinec@nic.cz>
PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE
PKG_BUILD_DIR:=$(BUILD_DIR)/pytest-forked-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python3-package.mk)

define Package/python3-pytest-forked
	SUBMENU:=Python
	SECTION:=lang
	CATEGORY:=Languages
	TITLE:=pytest-forked
	URL:=https://github.com/pytest-dev/pytest-forked
	DEPENDS:=+python3 +python3-pytest
endef

define Package/python3-pytest-forked/description
  pytest module to run tests in isolated forked subprocesses
endef

define Build/Compile
	$(call Build/Compile/Py3Mod,,\
		install --prefix="$(PKG_INSTALL_DIR)/usr" \
	)
endef

$(eval $(call Py3Package,python3-pytest-forked))
$(eval $(call BuildPackage,python3-pytest-forked))

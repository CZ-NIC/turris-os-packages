include $(TOPDIR)/rules.mk

PKG_NAME:=python3-pytest-xdist
PKG_RELEASE:=1
PKG_VERSION:=1.26.1

PKG_SOURCE_URL:=https://files.pythonhosted.org/packages/dc/99/c11b8bc2414ddb4101490a3963eb6f74d82f66223bef431b18fb38012476
PKG_HASH:=d03d1ff1b008458ed04fa73e642d840ac69b4107c168e06b71037c62d7813dd4
PKG_SOURCE:=pytest-xdist-$(PKG_VERSION).tar.gz

PKG_MAINTAINER:=Jan Pavlinec <jan.pavlinec@nic.cz>
PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE
PKG_BUILD_DIR:=$(BUILD_DIR)/pytest-xdist-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python3-package.mk)

define Package/python3-pytest-xdist
	SUBMENU:=Python
	SECTION:=lang
	CATEGORY:=Languages
	TITLE:=pytest-xdist
	URL:=https://docs.pytest.org/en/3.0.0/xdist.html
	DEPENDS:=+python3 +python3-pytest
endef

define Package/python3-pytest-xdist/description
   pytest distributed testing plugin
endef

define Build/Compile
	$(call Build/Compile/Py3Mod,,\
		install --prefix="$(PKG_INSTALL_DIR)/usr" \
	)
endef

$(eval $(call Py3Package,python3-pytest-xdist))
$(eval $(call BuildPackage,python3-pytest-xdist))

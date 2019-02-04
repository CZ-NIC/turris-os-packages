#
# Copyright (C) 2014-2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python3-setuptools
PKG_VERSION:=40.7.3
PKG_RELEASE:=1

PKG_SOURCE:=setuptools-$(PKG_VERSION).zip
PKG_SOURCE_URL:=https://files.pythonhosted.org/packages/90/86/00ab839a8647e0fee435fe77f70795865ca4534387872a6c23b22fd85ac8/
PKG_HASH:=702fdd31cb10a65a94beba1a7d89219a58d2587a349e0a1b7827b133e99ca430

HOST_BUILD_DEPENDS:=python3 python3/host

PKG_LICENSE:=PSF

PKG_BUILD_DIR:=$(BUILD_DIR)/python3-setuptools-$(PKG_VERSION)
PKG_UNPACK=unzip -d $(PKG_BUILD_DIR) $(DL_DIR)/$(PKG_SOURCE) && mv $(PKG_BUILD_DIR)/*/* $(PKG_BUILD_DIR)

HOST_BUILD_DIR:=$(BUILD_DIR_HOST)/$(PKG_NAME)-$(PKG_VERSION)
HOST_UNPACK=unzip -d $(HOST_BUILD_DIR) $(DL_DIR)/$(PKG_SOURCE) && mv $(HOST_BUILD_DIR)/*/* $(HOST_BUILD_DIR)

include $(INCLUDE_DIR)/host-build.mk
include $(INCLUDE_DIR)/package.mk
$(call include_mk, python3-package.mk)
$(call include_mk, python3-host.mk)

define Package/python3-setuptools
	SUBMENU:=Python
	SECTION:=lang
	CATEGORY:=Languages
	TITLE:=Tool for installing Python $(PYTHON3_VERSION) packages.
	URL:=https://bitbucket.org/pypa/setuptools
	DEPENDS:=+python3 +python3-dev +python3-lib2to3
	MAINTAINER:=Alexandru Ardelean <ardeleanalex@gmail.com>
endef

define Package/python3-setuptools/description
	Easily download, build, install, upgrade, and uninstall Python $(PYTHON3_VERSION) packages
endef

define Build/Compile
	$(call Build/Compile/Py3Mod,,\
		install --root="$(PKG_INSTALL_DIR)" --prefix="/usr" \
		--single-version-externally-managed \
	)
endef

define Build/InstallDev
	$(INSTALL_DIR) $(PYTHON3_LIB_DIR)
	$(CP) \
		$(PKG_INSTALL_DIR)$(PYTHON3_PKG_DIR)/* \
		$(PYTHON3_LIB_DIR)
endef

define Py3Package/python3-setuptools/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/easy_install-$(PYTHON3_VERSION) $(1)/usr/bin/
	$(LN) easy_install-$(PYTHON3_VERSION) $(1)/usr/bin/easy_install3
endef

define Host/Compile
	$(call Build/Compile/HostPy3Mod,,\
		install --root="$(STAGING_DIR_HOSTPKG)" --prefix="" \
		--single-version-externally-managed \
	)
endef

define Host/Install
endef

$(eval $(call HostBuild))

$(eval $(call Py3Package,python3-setuptools))
$(eval $(call BuildPackage,python3-setuptools))

#
# Copyright (C) 2014 CZ.NIC, z. s. p. o. (http://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=slimit
PKG_VERSION:=0.8.1
PKG_RELEASE:=1

PKG_SOURCE:=slimit-0.8.1.zip
PKG_SOURCE_URL:=https://pypi.python.org/packages/source/s/slimit/
PKG_MD5SUM:=5f5f86e98940a1e71a6a30d501e0d733

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)
HOST_BUILD_DEPENDS:=python/host python-ply/host


include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/host-build.mk
$(call include_mk, python-package.mk)

define Package/python-slimit
	SUBMENU:=Python
	SECTION:=lang
	CATEGORY:=Languages
	TITLE:=python-slimit
	URL:=http://slimit.readthedocs.org
	DEPENDS:=+python +python-ply
	MAINTAINER:=Jan Cermak <jan.cermak@nic.cz>
endef

define Package/python-slimit/description
	SlimIt - JavaScript minifier written in Python.
endef

define Build/Compile
	$(call Build/Compile/PyMod,,install --prefix=/usr --root=$(PKG_INSTALL_DIR))
endef

define Host/Compile
	$(call Build/Compile/Host/PyMod,,install --prefix=$(STAGING_DIR_HOST))
endef

define Host/Install
	$(INSTALL_BIN) ./files/slimit-wrapper.sh $(STAGING_DIR_HOST)/bin/slimit
	# copy a wrapper script so just "slimit" can be called from buildroot environment
	$(SED) 's~python~$(HOST_PYTHON_BIN)~' $(STAGING_DIR_HOST)/bin/slimit
endef

define Package/python-slimit/install
endef

$(eval $(call BuildPackage,python-slimit))
$(eval $(call HostBuild))

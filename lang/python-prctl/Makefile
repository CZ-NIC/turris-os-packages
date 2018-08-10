#
# Copyright (C) 2018 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python-prctl
PKG_VERSION:=1.6.1
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://pypi.python.org/packages/2c/a6/a866caf122908583f5f5e27217ca7f956c616e48e35cdb2a4a60ab4c7ad8/
PKG_MD5SUM:=5f36d6a1e832ca29f9fc458b5ace1627

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)
PKG_BUILD_DEPENDS:=python3 python libcap

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python-package.mk)
$(call include_mk, python3-package.mk)

define Package/Common
	SUBMENU:=Python
	SECTION:=lang
	CATEGORY:=Languages
	URL:=https://pythonhosted.org/python-prctl/
	MAINTAINER:=CZ.NIC <packaging@turris.cz>
endef

define Package/python-prctl
	$(call Package/Common)
	TITLE:=python-prctl
	DEPENDS:=+python-light +libcap
endef

define Package/python3-prctl
	$(call Package/Common)
	TITLE:=python3-prctl
	DEPENDS:=+python3-light +libcap
endef

define Package/$(PKG_NAME)/description
	Python(ic) interface to the linux prctl syscall
endef

define Build/Compile
	$(call Build/Compile/PyMod,., \
		install --prefix="/usr" --root="$(PKG_INSTALL_DIR)/py2" \
	)
	$(call Build/Compile/Py3Mod,., \
		install --prefix="/usr" --root="$(PKG_INSTALL_DIR)/py3" \
	)
endef

PKG_INSTALL_DIR_ORIG:="$(PKG_INSTALL_DIR)"
PKG_INSTALL_DIR:="$(PKG_INSTALL_DIR_ORIG)/py2"
$(eval $(call PyPackage,python-prctl))
PKG_INSTALL_DIR:="$(PKG_INSTALL_DIR_ORIG)/py3"
$(eval $(call Py3Package,python3-prctl))
PKG_INSTALL_DIR:="$(PKG_INSTALL_DIR_ORIG)"

$(eval $(call BuildPackage,python-prctl))
$(eval $(call BuildPackage,python3-prctl))

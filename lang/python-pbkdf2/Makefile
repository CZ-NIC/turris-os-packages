#
# Copyright (C) 2018 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=pbkdf2
PKG_VERSION:=1.3
PKG_RELEASE:=3

PKG_SOURCE:=pbkdf2-1.3.tar.gz
PKG_SOURCE_URL:=https://pypi.python.org/packages/source/p/pbkdf2/
PKG_MD5SUM:=40cda566f61420490206597243dd869f

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)
PKG_BUILD_DEPENDS:=python python3

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python-package.mk)
$(call include_mk, python3-package.mk)

define Package/Common
	SUBMENU:=Python
	SECTION:=lang
	CATEGORY:=Languages
	URL:=https://www.dlitz.net/software/python-pbkdf2/
	MAINTAINER:=CZ.NIC <packaging@turris.cz>
endef

define Package/python-pbkdf2
	$(call Package/Common)
	TITLE:=python-pbkdf2
	DEPENDS:=+python-light +python-openssl
endef

define Package/python3-pbkdf2
	$(call Package/Common)
	TITLE:=python3-pbkdf2
	DEPENDS:=+python3-light +python3-openssl
endef

define Package/python-pbkdf2/description
	PKCS#5 v2.0 PBKDF2 Module for Python
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
$(eval $(call PyPackage,python-pbkdf2))
PKG_INSTALL_DIR:="$(PKG_INSTALL_DIR_ORIG)/py3"
$(eval $(call Py3Package,python3-pbkdf2))
PKG_INSTALL_DIR:="$(PKG_INSTALL_DIR_ORIG)"

$(eval $(call BuildPackage,python-pbkdf2))
$(eval $(call BuildPackage,python3-pbkdf2))

#
# Copyright (C) 2015 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python3-pyyaml
PKG_VERSION:=3.12
PKG_RELEASE:=2

PKG_SOURCE:=PyYAML-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://pyyaml.org/download/pyyaml/
PKG_MD5SUM:=4c129761b661d181ebf7ff4eb2d79950

PKG_BUILD_DIR:=$(BUILD_DIR)/PyYAML-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python3-package.mk)

define Package/python3-pyyaml
  SUBMENU:=Python
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=YAML parser and emitter for Python
  URL:=http://pyyaml.org/wiki/PyYAML
  DEPENDS:=+python3-light
endef

define Package/python3-pyyaml/description
  YAML parser and emitter for Python
endef

define Build/Compile
	$(call Build/Compile/Py3Mod,, \
		--without-libyaml \
		install --root="$(PKG_INSTALL_DIR)" --prefix="/usr"  \
	)
endef

$(eval $(call Py3Package,python3-pyyaml))
$(eval $(call BuildPackage,python3-pyyaml))

#
# Copyright (C) 2015 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python3-pyyaml
PKG_VERSION:=4.1
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://github.com/yaml/pyyaml/archive/

PKG_MD5SUM:=049d79ccea9a6a7fac5ef7011d069a01b8314de920bc4e8d8c425e62e21b26f0

PKG_BUILD_DIR:=$(BUILD_DIR)/pyyaml-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

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

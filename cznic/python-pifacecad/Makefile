#
# Copyright (C) 2015 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python-pifacecad
PKG_VERSION:=2.0.8
PKG_RELEASE:=1
PKG_LICENSE:=GPL-3.0
PKG_LICENSE_FILES:=COPYING

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/piface/pifacecad.git
PKG_SOURCE_VERSION:=236fd73e316a22f4119818e8c5319b669ddfc226
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python-package.mk

define Package/python-pifacecad
  SECTION:=language-python
  CATEGORY:=Languages
  SUBMENU:=Python
  TITLE:=python-pifacecad
  URL:=http://python.sourceforge.net/
  DEPENDS:=+python +python-pifacecommon
  MAINTAINER:=Pavel Spirek <pavel.spirek@nic.cz>
endef

define Package/python-pifacecad/description
 PiFace Control and Display Python module.
 This version is modified specifically for Turris router.
endef

define Build/Compile
	$(call Build/Compile/PyMod,,install --prefix=/usr --root=$(PKG_INSTALL_DIR))
endef

define Package/python-pifacecad/install
	$(INSTALL_DIR) $(1)$(PYTHON_PKG_DIR)
	$(CP) \
		$(PKG_INSTALL_DIR)$(PYTHON_PKG_DIR)/* \
		$(1)$(PYTHON_PKG_DIR)
endef

$(eval $(call BuildPackage,python-pifacecad))

#
# Copyright (C) 2019 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python-pifacecommon
PKG_VERSION:=4.2.2
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://files.pythonhosted.org/packages/source/p/pifacecommon/
PKG_HASH:=294627d4cf92149bce7f32711bbb1242574bfd1363df37dc60e058481c293b3c

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=LGPL-3.0-or-later
PKG_LICENSE_FILES:=COPYING

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

define Package/python3-pifacecommon
  SUBMENU:=Python
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=The PiFace common functions module
  URL:=https://github.com/piface/pifacecommon
  DEPENDS:=+python3-light
  VARIANT:=python3
endef

define Package/python3-pifacecommon/description
  Common functions for interacting with PiFace products.
endef

$(eval $(call Py3Package,python3-pifacecommon))
$(eval $(call BuildPackage,python3-pifacecommon))
$(eval $(call BuildPackage,python3-pifacecommon-src))

#
# Copyright (C) 2015 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python3-markdown
PKG_VERSION:=2.6.11
PKG_RELEASE:=1

PKG_SOURCE:=Markdown-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://pypi.python.org/packages/source/m/markdown/
PKG_MD5SUM:=a67c1b2914f7d74eeede2ebe0fdae470

PKG_BUILD_DIR:=$(BUILD_DIR)/Markdown-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

define Package/$(PKG_NAME)
  TITLE:=Markdown implementation in Python
  SUBMENU:=Python
  SECTION:=lang
  CATEGORY:=Languages
  DEPENDS:=+python3-light
  VARIANT:=python3
endef

define Package/$(PKG_NAME)/description
  A fast and complete Python implementation of Markdown.
endef

$(eval $(call Py3Package,python3-markdown))
$(eval $(call BuildPackage,python3-markdown))
$(eval $(call BuildPackage,python3-markdown-src))

#
# Copyright (C) 2015-2019 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python-markdown
PKG_VERSION:=3.1
PKG_RELEASE:=1

PKG_SOURCE:=Markdown-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://pypi.python.org/packages/source/m/markdown/
PKG_HASH:=fc4a6f69a656b8d858d7503bda633f4dd63c2d70cf80abdc6eafa64c4ae8c250

PKG_BUILD_DIR:=$(BUILD_DIR)/$(BUILD_VARIANT)-Markdown-$(PKG_VERSION)

PKG_LICENSE:=BSD-3-Clause
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python-package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

PKG_UNPACK:=$(HOST_TAR) -C $(PKG_BUILD_DIR) --strip-components=1 -xzf $(DL_DIR)/$(PKG_SOURCE)

define Package/python-markdown/Default
  SECTION:=lang
  CATEGORY:=Languages
  SUBMENU:=Python
  TITLE:=Markdown implementation in Python
  URL:=https://python-markdown.github.io/
endef

define Package/python-markdown
$(call Package/python-markdown/Default)
  DEPENDS+= \
      +PACKAGE_python-markdown:python-light
  VARIANT:=python
endef

define Package/python3-markdown
$(call Package/python-markdown/Default)
  DEPENDS+= \
      +PACKAGE_python3-markdown:python3-light
  VARIANT:=python3
endef

define Package/python-markdown/description
A fast and complete Python implementation of Markdown.
endef

define Package/python3-markdown/description
$(call Package/python-markdown/description)
.
(Variant for Python3)
endef

$(eval $(call PyPackage,python-markdown))
$(eval $(call BuildPackage,python-markdown))
$(eval $(call BuildPackage,python-markdown-src))

$(eval $(call Py3Package,python3-markdown))
$(eval $(call BuildPackage,python3-markdown))
$(eval $(call BuildPackage,python3-markdown-src))

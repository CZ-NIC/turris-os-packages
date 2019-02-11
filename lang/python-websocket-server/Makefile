#
# Copyright (C) 2018 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=websocket_server
PKG_VERSION:=0.4
PKG_RELEASE:=6

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://pypi.python.org/packages/74/64/e86581ee7775a2e08aca530b41e1a1e3ee6b320233b1eff301dcb86d1636/
PKG_MD5SUM:=0026f2a6696e2ebdb4c70a35568ff22c

PKG_LICENSE:=MIT
PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

PKG_BUILD_DIR:=$(BUILD_DIR)/$(BUILD_VARIANT)-$(PKG_NAME)-$(PKG_VERSION)
PKG_BUILD_DEPENDS:=python3-setuptools

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python-package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

PKG_UNPACK:=$(HOST_TAR) -C $(PKG_BUILD_DIR) --strip-components=1 -xzf $(DL_DIR)/$(PKG_SOURCE)

define Package/python-websocket-server/Default
	SUBMENU:=Python
	SECTION:=lang
	CATEGORY:=Languages
	URL:=https://github.com/Pithikos/python-websocket-server
	MAINTAINER:=CZ.NIC <packaging@turris.cz>
	DEPENDS:=
endef

define Package/python-websocket-server
	$(call Package/python-websocket-server/Default)
	TITLE:=python-websocket-server
	DEPENDS+=+python-light
	VARIANT:=python
endef

define Package/python3-websocket-server
	$(call Package/python-websocket-server/Default)
	TITLE:=python3-websocket-server
	DEPENDS+=+python3-light
	VARIANT:=python3
endef

define Package/python-websocket-server/description
A minimalistic websocket server implementation with no dependencies that works both Python2 and Python3.
endef

define Package/python3-websocket-server/description
  $(call Package/python-websocket-server/description)
  .
  (Variant for Python3)
endef

$(eval $(call PyPackage,python-websocket-server))
$(eval $(call BuildPackage,python-websocket-server))
$(eval $(call BuildPackage,python-websocket-server-src))

$(eval $(call Py3Package,python3-websocket-server))
$(eval $(call BuildPackage,python3-websocket-server))
$(eval $(call BuildPackage,python3-websocket-server-src))

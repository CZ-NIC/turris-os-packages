#
# Copyright (C) 2007-2019 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python3-requests
PKG_VERSION:=2.21.0
PKG_RELEASE:=1
PKG_LICENSE:=Apache-2.0

PKG_SOURCE:=requests-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://files.pythonhosted.org/packages/source/r/requests
PKG_HASH:=502a824f31acdacb3a35b6690b5fbf0bc41d63a24a45c4004352b0242707598e
PKG_BUILD_DIR:=$(BUILD_DIR)/python3-requests-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

PKG_UNPACK:=$(HOST_TAR) -C $(PKG_BUILD_DIR) --strip-components=1 -xzf $(DL_DIR)/$(PKG_SOURCE)

define Package/python3-requests
  SUBMENU:=Python
  SECTION:=lang
  CATEGORY:=Languages
  MAINTAINER:=Eneas U de Queiroz <cote2004-github@yahoo.com>
  URL:=http://python-requests.org/
  TITLE:=HTTP library for Python3
  DEPENDS:=+python3-light +python3-chardet +python3-idna +python3-urllib3 +python3-certifi
endef

define Package/python3-requests/description
  Requests is the only Non-GMO HTTP library for Python, safe for human consumption.
.
(Variant for Python3)
endef

define Build/Compile
	$(call Py3Build/Compile)
endef

$(eval $(call Py3Package,python3-requests))
$(eval $(call BuildPackage,python3-requests))
$(eval $(call BuildPackage,python3-requests-src))

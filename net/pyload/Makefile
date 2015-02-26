#
# Copyright (C) 2011 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=pyload
PKG_RELEASE:=2
PKG_SOURCE_PROTO:=svn
PKG_SOURCE_BRANCH:=trunk
PKG_SOURCE_URL:=https://github.com/pyload/pyload.git/$(PKG_SOURCE_BRANCH)
PKG_SOURCE_VERSION:=4089
PKG_VERSION:=r$(PKG_SOURCE_VERSION)
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_SOURCE_VERSION)/$(PKG_NAME)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_SOURCE_VERSION)/

include $(INCLUDE_DIR)/package.mk

define Package/pyload
  SECTION:=net
  CATEGORY:=Network
  DEPENDS:=+python +pyopenssl +python-curl +python-crypto +python-django \
	+python-imaging-library +python-sqlite3 +js +tesseract +unrar
  TITLE:=A fast, lightweight and full featured download manager
  URL:=http://pyload.org
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/pyload/install
	$(INSTALL_DIR) $(1)/usr/share/python
	$(CP) $(PKG_BUILD_DIR)/pyload $(1)/usr/share/python/
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/pyload.init $(1)/etc/init.d/pyload
	$(INSTALL_DIR) $(1)/usr/bin
	$(LN) ../share/python/pyload/pyLoadCore.py $(1)/usr/bin/pyload
endef

$(eval $(call BuildPackage,pyload))

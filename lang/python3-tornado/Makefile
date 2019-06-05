#
# Copyright (C) 2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python3-tornado
PKG_VERSION:=6.0.2
PKG_RELEASE:=1

PKG_LICENSE:=Apache 2.0
PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

PKG_SOURCE:=tornado-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://pypi.python.org/packages/source/t/tornado/
PKG_HASH:=457fcbee4df737d2defc181b9073758d73f54a6cfc1f280533ff48831b39f4a8
PKG_BUILD_DIR:=$(BUILD_DIR)/tornado-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

define Package/python3-tornado
	SECTION:=lang
	CATEGORY:=Languages
	SUBMENU:=Python
	TITLE:=Tornado is an asynchronous Python web server
	URL:=http://www.tornadoweb.org
	DEPENDS:=+python3 +libcurl +ca-certificates
	VARIANT:=python3
endef

define Package/python3-tornado/description
 Tornado is a Python web framework and asynchronous networking library,
 originally developed at FriendFeed. By using non-blocking network I/O,
 Tornado can scale to tens of thousands of open connections, making it
 ideal for long polling, WebSockets, and other applications that require
 a long-lived connection to each user.
endef

$(eval $(call Py3Package,python3-tornado))
$(eval $(call BuildPackage,python3-tornado))
$(eval $(call BuildPackage,python3-tornado-src))

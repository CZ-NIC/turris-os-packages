#
# Copyright (C) 2020 CZ.NIC z.s.p.o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python-tornado
PKG_VERSION:=6.0.3
PKG_RELEASE:=1

PYPI_NAME:=tornado
PKG_HASH:=c845db36ba616912074c5b1ee897f8e0124df269468f25e4fe21fe72f6edd7a9

PKG_MAINTAINER:=Josef Schlehofer <josef.schlehofer@nic.cz>
PKG_LICENSE:=Apache-2.0
PKG_LICENSE_FILES:=LICENSE

include $(TOPDIR)/feeds/packages/lang/python/pypi.mk
include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

define Package/python3-tornado
  SECTION:=lang
  CATEGORY:=Languages
  SUBMENU:=Python
  TITLE:=Tornado is an asynchronous Python web server
  URL:=https://www.tornadoweb.org
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

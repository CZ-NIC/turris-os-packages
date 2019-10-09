#
# Copyright (C) 2019 CZ.NIC z.s.p.o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=reforis-diagnostics-plugin
PKG_VERSION:=2.0.0
PKG_RELEASE:=3

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/reforis/reforis_diagnostics
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_VERSION:=v$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-3.0-or-later
PKG_LICENSE_FILES:=LICENSE

PKG_BUILD_DEPENDS:=\
	node/host \
	foris-plugins-distutils/host \

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

define Package/reforis-diagnostics-plugin
  TITLE:=reforis
  URL:=https://gitlab.labs.nic.cz/turris/reforis/reforis_diagnostics
  DEPENDS:= \
    +reforis \

  VARIANT=python3
endef

define Package/reforis-diagnostics-plugin/description
  Reforis diagnostics plugin
endef

define Py3Package/reforis-diagnostics-plugin/filespec
+|$(PYTHON3_PKG_DIR)
-|$(PYTHON3_PKG_DIR)/reforis_static/__init__.py*
endef

define Package/reforis-diagnostics-plugin/postinst
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || {
	/etc/init.d/lighttpd enable
	/usr/bin/maintain-lighttpd-restart
}
endef

define Package/reforis-diagnostics-plugin/prerm
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || /usr/bin/maintain-lighttpd-restart
endef

$(eval $(call Py3Package,reforis-diagnostics-plugin))
$(eval $(call BuildPackage,reforis-diagnostics-plugin))
$(eval $(call BuildPackage,reforis-diagnostics-plugin-src))

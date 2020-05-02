#
# Copyright (C) 2017 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=pakon-dev-detect
PKG_VERSION:=2

include $(INCLUDE_DIR)/package.mk

define Package/pakon-dev-detect
  TITLE:=pakon-dev-detect
  DEPENDS:=+pakon
endef

Build/Compile:=:
Build/Install:=:

define Package/pakon-dev-detect/postinst
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || {
	/sbin/uci -q set pakon.monitor.notify_new_devices=1
	/sbin/uci commit pakon
	/etc/init.d/pakon-monitor restart 2>/dev/null
}
endef

define Package/pakon-dev-detect/prerm
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || {
	/sbin/uci -q set pakon.monitor.notify_new_devices=0
	/sbin/uci commit pakon
	/etc/init.d/pakon-monitor restart 2>/dev/null
}
endef

$(eval $(call BuildPackage,pakon-dev-detect))

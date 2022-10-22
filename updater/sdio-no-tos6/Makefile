#
## Copyright (C) 2022 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=sdio-no-tos6
PKG_VERSION:=0.1.0
PKG_RELEASE:=1

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

include $(INCLUDE_DIR)/package.mk

define Package/sdio-no-tos6
  SECTION:=updater
  CATEGORY:=Turris Updater
  TITLE:=Turris OS 6.x missing SDIO support
  DEPENDS:=@TARGET_mvebu_cortexa53_DEVICE_cznic_turris-mox
endef

define Package/sdio-no-tos6/postinst
[ -n "$$IPKG_INSTROOT" ] || {
	found=
	for device in /sys/bus/sdio/devices/*; do
		[ -d "$$device" ] || continue
		if [ "$$(cat $$device/vendor)" = "0x02df" ] && [ "$$(cat $$device/device)" = "0x9141" ]; then
			create_notification -s news 'Turris OS 6.0 is not available on systems with SDIO yet'
			switch-branch --force hbs-sdio 2>/dev/null
			found=y
			break
		fi
	done
	if [ -z "$$found" ]; then
		switch-branch hbs 2>/dev/null
	fi
}
endef

Package/sdio-no-tos6/install:=:
Build/Compile:=

$(eval $(call BuildPackage,sdio-no-tos6))

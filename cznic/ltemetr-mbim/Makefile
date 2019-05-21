#
## Copyright (C) 2019 CZ.NIC z.s.p.o. (https://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=ltemetr-mbim
PKG_VERSION:=0.1
PKG_RELEASE:=1

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-2.0-or-later

PKG_BUILD_DIR:=$(BUILD_DIR)/$(BUILD_VARIANT)-ltemetr-mbim-v$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  TITLE:=Tools for mbim
  DEPENDS:=\
    +umbim +kmod-usb-net-cdc-mbim +kmod-usb-net-sierrawireless \
    +kmod-usb-serial-wwan +kmod-usb-serial-sierrawireless +kmod-usb-serial-qualcomm \
    +coreutils-date
endef

define Package/$(PKG_NAME)/description
  Mbim support
endef

define Build/Compile
  true
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR)  $(1)/lib/netifd/proto
	$(INSTALL_BIN)  ./files/mbim.sh $(1)/lib/netifd/proto/mbim-ltemetr.sh
endef

define Package/$(PKG_NAME)/postinst
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || {
	mv /lib/netifd/proto/mbim.sh /lib/netifd/proto/mbim.sh.orig
	cp /lib/netifd/proto/mbim-ltemetr.sh /lib/netifd/proto/mbim.sh

	uci set updater.override.disable=1
	uci commit

	uci set network.lte=interface
	uci set network.lte.proto=mbim
	uci set network.lte.device=/dev/cdc-wdm0
	uci set network.lte.apn=internet
	uci set network.lte.auth=none
	uci commit

	wan_nets=`uci get firewall.@zone[1].network`
	uci delete firewall.@zone[1].network
	for net in $${wan_nets}; do uci add_list firewall.@zone[1].network=$${net}; done
	uci add_list firewall.@zone[1].network='lte'
	uci commit
	/etc/init.d/network restart
}
endef

define Package/$(PKG_NAME)/prerm
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || {
	mv /lib/netifd/proto/mbim.sh.orig /lib/netifd/proto/mbim.sh
	uci delete network.lte
	uci del_list firewall.@zone[1].network='lte'
	uci set updater.override.disable=0
	uci commit
}
endef
$(eval $(call BuildPackage,$(PKG_NAME)))

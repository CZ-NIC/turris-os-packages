#
## Copyright (C) 2013 CZ.NIC z.s.p.o. <michal.vaner@nic.cz>
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=libatsha204
PKG_VERSION:=1
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=ssh://git@git.nic.cz/router/libatsha204
PKG_SOURCE:=$(PKG_NAME).tar.gz
PKG_SOURCE_VERSION:=5ef0af304346f5184dd31fe7a45de364f3681018
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_MAINTAINER:=Michal Vaner <michal.vaner@nic.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/libatsha204
	TITLE:=libatsha204
	DEPENDS:=+libopenssl +libunbound
endef

define Build/Compile
	$(MAKE_VARS) $(MAKE) -C $(PKG_BUILD_DIR) $(MAKE_FLAGS) NO_DOC=1 USE_LAYER=USE_LAYER_EMULATION CONFIG_PATH=/etc/atsha.sw
endef

define Package/libatsha204/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/atsha204cmd $(1)/usr/bin/

	$(INSTALL_DIR) $(1)/usr/lib
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/lib/libatsha204.so $(1)/usr/lib/
endef

define Package/libatsha204/postinst
#!/bin/sh

if [ -f /etc/atsha.sw ] ; then
	exit
fi

MAC=$$(ifconfig | head -n1 | sed -e 's/.* HWaddr //')
touch /tmp/atsha.sw
chmod 0600 /tmp/atsha.sw
echo "00 00 00 $$MAC" >/tmp/atsha.sw
for i in `seq 1 16` ; do
	KEY=$$(dd if=/dev/urandom bs=1 count=32 | hexdump -C | sed -e 's/^[^ ]*//;s/|.*//;s/ //g' | tr '\n' ' ' | tr '[a-z]' '[A-Z]' | sed -e 's/ //g')
	echo "$$KEY" >>/tmp/atsha.sw
done
echo 00 00 00 00 >>/tmp/atsha.sw
for i in `seq 1 15` ; do
	echo FF FF FF FF >>/tmp/atsha.sw
done
chmod 0400 /tmp/atsha.sw

mv /tmp/atsha.sw $${IPKG_INSTROOT}/etc
endef

$(eval $(call BuildPackage,libatsha204))

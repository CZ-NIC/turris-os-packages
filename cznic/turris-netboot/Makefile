#
## Copyright (C) 2016 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=turris-netboot
PKG_VERSION:=0.5.8
PKG_RELEASE:=1
BB_VERSION:=1.29.3
PKG_BB_SOURCE:=busybox-$(BB_VERSION).tar.bz2
PKG_BB_SOURCE_URL:=https://www.busybox.net/downloads \
		http://sources.buildroot.net
PKG_BB_HASH:=2f321fa72d539128a3a6f9f35a422656756b7283
PKG_MAINTAINER:=Michal Hrusecky <michal.hrusecky@nic.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)
PKG_BUILD_DEPENDS:=opkg/host
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/turris-netboot.git
PKG_SOURCE_VERSION:=v$(PKG_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.bz2
ROOTFS_INSTALL:=+libgcc +libc +libubox +libpthread +librt +libattr +libuuid +zlib +libblkid +liblzo +uboot-envtools +libopenssl +libpcre +openssh-client +openssh-keygen +openssh-client-utils
PKG_BUILD_DEPENDS:=opkg/host busybox openssh-utils openssh-client uboot-envtools

include $(INCLUDE_DIR)/kernel.mk
include $(INCLUDE_DIR)/package.mk

define Package/turris-netboot-data
  TITLE:=Turris Netboot data package
endef

define Package/turris-netboot-tools
  TITLE:=Turris Netboot tools
  DEPENDS:=+dnsmasq +dtc +uboot-mkimage +openssh-server +python3-cryptography +wget +foris-client
endef

define Build/Prepare
	$(PKG_UNPACK)
	mkdir -p "$(PKG_BUILD_DIR)/rootfs/sbin"
	mkdir -p "$(PKG_BUILD_DIR)/rootfs/etc"
	echo -e 'nameserver 193.17.47.1\nnameserver 2001:148f:ffff::1\nnameserver 185.43.135.1' > "$(PKG_BUILD_DIR)/rootfs/etc/resolv.conf"
	mkdir -p "$(PKG_BUILD_DIR)/rootfs/tmp"
	mkdir -p "$(PKG_BUILD_DIR)/rootfs/var/lock"
	mkdir -p "$(PKG_BUILD_DIR)/busybox"
	echo "root::0:0:root:/:/bin/sh" > "$(PKG_BUILD_DIR)/rootfs/etc/passwd"
	echo "/bin/sh" > "$(PKG_BUILD_DIR)/rootfs/etc/shells"
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/rescue.sh "$(PKG_BUILD_DIR)/rootfs/init"
	$(SCRIPT_DIR)/download.pl "$(DL_DIR)" "$(PKG_BB_SOURCE)" "$(PKG_BB_HASH)" "$(PKG_BB_SOURCE)" $(foreach url,$(PKG_BB_SOURCE_URL),"$(url)")
	$(HOST_TAR) -C $(PKG_BUILD_DIR)/busybox --strip-components=1 -xjf $(DL_DIR)/$(PKG_BB_SOURCE)
	mkdir -p "$(PKG_BUILD_DIR)"/rootfs//usr/share/udhcpc
	cp "$(PKG_BUILD_DIR)"/busybox/examples/udhcp/simple.script "$(PKG_BUILD_DIR)"/rootfs//usr/share/udhcpc/default.script
	chmod a+rx "$(PKG_BUILD_DIR)"/rootfs//usr/share/udhcpc/default.script
	cp ./files/rootfs.extra "$(PKG_BUILD_DIR)/rootfs.extra"
	cp ./files/mox.its "$(PKG_BUILD_DIR)/rescue.its"
endef

define Build/Configure
	# Busybox
	cp files/busybox-config $(PKG_BUILD_DIR)/busybox/.config
	$(MAKE) -C "$(PKG_BUILD_DIR)/busybox" $(MAKE_FLAGS) oldconfig
endef

define Package/turris-netboot-tools/conffiles
/etc/config/netboot
endef

define Build/Compile
	rm -rf "$(PKG_BUILD_DIR)"/rootfs/usr/lib/opkg
	cd "$(PKG_BUILD_DIR)/busybox"; $(MAKE) $(PKG_JOBS) -C "$(PKG_BUILD_DIR)/busybox" \
		$(MAKE_FLAGS) CONFIG_PREFIX="$(PKG_BUILD_DIR)/rootfs" all install
	export IPKG_NO_SCRIPT=1;\
	export IPKG_INSTROOT="$(PKG_BUILD_DIR)/rootfs"; \
	export TMPDIR="$(PKG_BUILD_DIR)/rootfs/tmp"; \
	for pkg in $(ROOTFS_INSTALL); do\
		find $(OUTPUT_DIR) -name `echo $$$$pkg | sed 's|^+||'`_*_$(PKGARCH).ipk -print -exec \
		$(STAGING_DIR_HOST)/bin/opkg --offline-root "$(PKG_BUILD_DIR)/rootfs" --force-depends install \{\} \; ;\
	done
	rm -rf "$(PKG_BUILD_DIR)/rootfs"/usr/lib/opkg
endef

define Package/turris-netboot-data/install
	$(INSTALL_DIR) $(1)/usr/share/turris-netboot
	cd $(LINUX_DIR); ./scripts/gen_initramfs_list.sh \
	-o $(1)/usr/share/turris-netboot/initrd-$(CONFIG_ARCH).gz -u squash -g squash \
	"$(PKG_BUILD_DIR)/rootfs" "$(PKG_BUILD_DIR)/rootfs.extra" 
	gzip -d $(1)/usr/share/turris-netboot/initrd-$(CONFIG_ARCH).gz
	$(INSTALL_DATA) ./files/mox.its $(1)/usr/share/turris-netboot
endef

define Package/turris-netboot-tools/postinst
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || {
/etc/init.d/cron restart
/usr/bin/netboot-setup
}
endef

define Package/turris-netboot-tools/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_DIR) $(1)/etc/cron.d
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/netboot $(1)/etc/config/netboot
	$(INSTALL_DATA) ./files/netboot-update.cron $(1)/etc/cron.d/netboot-update
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/server.sh $(1)/usr/bin/netboot-server
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/manage.sh $(1)/usr/bin/netboot-manager
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/setup.sh $(1)/usr/bin/netboot-setup
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/encrypt.py $(1)/usr/bin/netboot-encrypt
	$(INSTALL_DIR) $(1)/usr/share/turris-netboot
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/network-setup.sh $(1)/usr/share/turris-netboot/setup.sh
endef

$(eval $(call BuildPackage,turris-netboot-data))
$(eval $(call BuildPackage,turris-netboot-tools))

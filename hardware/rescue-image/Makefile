#
## Copyright (C) 2016 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=rescue-image
PKG_VERSION:=3.6.1
PKG_RELEASE:=$(AUTORELEASE)
BB_VERSION:=1.33.2
PKG_SOURCE:=busybox-$(BB_VERSION).tar.bz2
PKG_SOURCE_URL:=https://www.busybox.net/downloads \
		http://sources.buildroot.net
PKG_HASH:=6843ba7977081e735fa0fdb05893e3c002c8c5ad7c9c80da206e603cc0ac47e7
PKG_MAINTAINER:=Michal Hrusecky <michal.hrusecky@nic.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)
ROOTFS_INSTALL:=+libgcc +libc +libubox +mtd +libpthread +librt +libattr +libuuid +zlib +libblkid +liblzo +btrfs-progs +schnapps +dropbear +uboot-envtools +usign +cznic-repo-keys +libopenssl +libpcre +wget-ssl +libhavege +haveged
PKG_BUILD_DEPENDS:=opkg/host mtd btrfs-progs schnapps wget cznic-repo-keys usign uboot-tools dropbear haveged

KERNEL_BUILD_DIR:=$(PKG_BUILD_DIR)/kernel
PLATFORM_DIR:=$(TOPDIR)/target/linux/$(BOARD)

include $(INCLUDE_DIR)/target.mk
include $(INCLUDE_DIR)/kernel.mk
include $(INCLUDE_DIR)/kernel-build.mk
include $(INCLUDE_DIR)/kernel-defaults.mk
include $(INCLUDE_DIR)/quilt.mk
include $(INCLUDE_DIR)/package.mk

PATCH_DIR := $(PLATFORM_DIR)/patches$(if $(wildcard $(PLATFORM_DIR)/patches-$(KERNEL_PATCHVER)),-$(KERNEL_PATCHVER))
ifeq ($(CONFIG_TARGET_mvebu_cortexa53_DEVICE_cznic_turris-mox),y)
DEVICE := mox
else ifeq ($(CONFIG_TARGET_mvebu_cortexa9_DEVICE_cznic_turris-omnia),y)
DEVICE := omnia
else
DEVICE := unknown
endif
kernel_files=$(TOPDIR)/target/linux/$(BOARD)/files/. $(TOPDIR)/target/linux/generic/files/.

define Package/rescue-image
	TITLE:=rescue-image
	DEPENDS:=@(TARGET_mvebu_cortexa53_DEVICE_cznic_turris-mox||TARGET_mvebu_cortexa9_DEVICE_cznic_turris-omnia)
endef

define Build/Prepare
	mkdir -p "$(LINUX_DIR)"
	xzcat $(DL_DIR)/$(LINUX_SOURCE) | $(TAR) -C $(KERNEL_BUILD_DIR) $(TAR_OPTIONS)
	$(call Kernel/Patch/Default)
	mkdir -p "$(PKG_BUILD_DIR)/rootfs/sbin"
	mkdir -p "$(PKG_BUILD_DIR)/rootfs/etc"
	mkdir -p "$(PKG_BUILD_DIR)/rootfs/lib"
	echo -e 'nameserver 193.17.47.1\nnameserver 2001:148f:ffff::1\nnameserver 185.43.135.1' > "$(PKG_BUILD_DIR)/rootfs/etc/resolv.conf"
	mkdir -p "$(PKG_BUILD_DIR)/rootfs/tmp"
	mkdir -p "$(PKG_BUILD_DIR)/rootfs/var/lock"
	mkdir -p "$(PKG_BUILD_DIR)/busybox"
	echo "Turris Rescue $(PKG_VERSION)-$(PKG_RELEASE)" > "$(PKG_BUILD_DIR)/rootfs/version"
	echo "root::0:0:root:/:/bin/sh" > "$(PKG_BUILD_DIR)/rootfs/etc/passwd"
	echo "/bin/sh" > "$(PKG_BUILD_DIR)/rootfs/etc/shells"
	$(INSTALL_BIN) ./files/helpers.sh "$(PKG_BUILD_DIR)/rootfs/lib/helpers.sh"
	$(INSTALL_BIN) ./files/board_helpers.sh "$(PKG_BUILD_DIR)/rootfs/lib/board_helpers.sh"
	$(INSTALL_BIN) ./files/rescue.sh "$(PKG_BUILD_DIR)/rootfs/init"
	$(INSTALL_BIN) ./files/$(DEVICE).sh "$(PKG_BUILD_DIR)/rootfs/lib/board.sh"
	$(HOST_TAR) -C $(PKG_BUILD_DIR)/busybox --strip-components=1 -xjf $(DL_DIR)/$(PKG_SOURCE)
	mkdir -p "$(PKG_BUILD_DIR)"/rootfs//usr/share/udhcpc
	cp "$(PKG_BUILD_DIR)"/busybox/examples/udhcp/simple.script "$(PKG_BUILD_DIR)"/rootfs//usr/share/udhcpc/default.script
	chmod a+rx "$(PKG_BUILD_DIR)"/rootfs//usr/share/udhcpc/default.script
	cp ./files/rootfs.extra "$(PKG_BUILD_DIR)/rootfs.extra"
	cp ./files/$(DEVICE).its "$(PKG_BUILD_DIR)/rescue.its"
endef

define Build/Configure
	sed -i 's|^BOARD=.*|BOARD=$(DEVICE)|' "$(PKG_BUILD_DIR)/rootfs/init"
	# Kernel
	$(call Kernel/Configure)
	sed -i \
		-e 's|=m$$$$|=n|' \
		-e 's|^\(CONFIG_RD_.*\)=y|\1=n|' \
		-e 's|^\(CONFIG_KERNEL_.*\)=y|\1=n|' \
		-e 's|^\(CONFIG_NET_VENDOR_.*\)=y|\1=n|' "$(LINUX_DIR)/.config"
	cat ./files/kernel-config >> "$(LINUX_DIR)/.config"
	[ \! -f ./files/kernel-config-$(DEVICE) ] || cat ./files/kernel-config-$(DEVICE) >> "$(LINUX_DIR)/.config"
	# Busybox
	cp files/busybox-config $(PKG_BUILD_DIR)/busybox/.config
	$(MAKE) -C "$(PKG_BUILD_DIR)/busybox" $(PKG_JOBS) $(MAKE_FLAGS) oldconfig
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
	$(KERNEL_MAKE) $(PKG_JOBS) oldconfig $(KERNELNAME)
	cd $(LINUX_DIR); ./usr/gen_initramfs.sh \
	-o "$(PKG_BUILD_DIR)"/kernel/linux-$(LINUX_VERSION)/arch/$(LINUX_KARCH)/boot/initrd.gz -u squash -g squash \
	"$(PKG_BUILD_DIR)/rootfs" "$(PKG_BUILD_DIR)/rootfs.extra"
	cp "$(PKG_BUILD_DIR)"/kernel/linux-$(LINUX_VERSION)/arch/$(LINUX_KARCH)/boot/initrd.gz "$(PKG_BUILD_DIR)"/kernel/linux-$(LINUX_VERSION)/arch/$(LINUX_KARCH)/boot/initrd
	$(CP) "$(PKG_BUILD_DIR)"/rescue.its "$(PKG_BUILD_DIR)"/kernel/linux-$(LINUX_VERSION)/arch/$(LINUX_KARCH)/boot/rescue.its
endef

define Package/rescue-image/install
	install -d $(1)/usr/share/rescue-image
	cd "$(PKG_BUILD_DIR)"/kernel/linux-$(LINUX_VERSION)/arch/$(LINUX_KARCH)/boot/; ls; \
	PATH="$(PKG_BUILD_DIR)/kernel/linux-$(LINUX_VERSION)/scripts/dtc:$$PATH" \
	"$(STAGING_DIR_HOST)"/bin/mkimage -f rescue.its $(1)/usr/share/rescue-image/image.fit
	xz -k9 -F lzma $(1)/usr/share/rescue-image/image.fit
	[ "`stat -c '%s' $(1)/usr/share/rescue-image/image.fit.lzma`" -lt 7340032 ]
	[ "`stat -c '%s' $(1)/usr/share/rescue-image/image.fit.lzma`" -gt 1000000 ]
endef

$(eval $(call BuildPackage,rescue-image))

#
## Copyright (C) 2016 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=rescue-image
PKG_VERSION:=2.2.2
PKG_RELEASE:=0
BB_VERSION:=1.29.3
PKG_SOURCE:=busybox-$(BB_VERSION).tar.bz2
PKG_SOURCE_URL:=https://www.busybox.net/downloads \
		http://sources.buildroot.net
PKG_HASH:=0a367e19cdfd157e8258d87f893ee516
PKG_MAINTAINER:=Michal Hrusecky <michal.hrusecky@nic.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)
ROOTFS_INSTALL:=+libgcc +libc +libubox +mtd +libpthread +librt +libattr +libuuid +zlib +libblkid +liblzo +btrfs-progs +schnapps +dropbear +uboot-envtools +usign +cznic-repo-keys +libopenssl +libpcre +wget
PKG_BUILD_DEPENDS:=opkg/host mtd btrfs-progs schnapps wget cznic-repo-keys usign uboot-envtools dropbear

KERNEL_BUILD_DIR:=$(PKG_BUILD_DIR)/kernel
PLATFORM_DIR:=$(TOPDIR)/target/linux/$(BOARD)

include $(INCLUDE_DIR)/target.mk
include $(INCLUDE_DIR)/kernel.mk
include $(INCLUDE_DIR)/kernel-build.mk
include $(INCLUDE_DIR)/kernel-defaults.mk
include $(INCLUDE_DIR)/quilt.mk
include $(INCLUDE_DIR)/package.mk

PATCH_DIR := $(PLATFORM_DIR)/patches$(if $(wildcard $(PLATFORM_DIR)/patches-$(KERNEL_PATCHVER)),-$(KERNEL_PATCHVER))
DEVICE := $(subst DEVICE_cznic-,,$(CONFIG_TARGET_PROFILE))

define Package/rescue-image
	TITLE:=rescue-image
	DEPENDS:=@TARGET_mvebu_cortexa53_DEVICE_cznic-mox
endef

define Build/Prepare
	mkdir -p "$(LINUX_DIR)"
	xzcat $(DL_DIR)/$(LINUX_SOURCE) | $(TAR) -C $(KERNEL_BUILD_DIR) $(TAR_OPTIONS)
	$(call Kernel/Patch/Default)
	mkdir -p "$(PKG_BUILD_DIR)/rootfs/sbin"
	mkdir -p "$(PKG_BUILD_DIR)/rootfs/etc"
	echo -e 'nameserver 193.17.47.1\nnameserver 2001:148f:ffff::1\nnameserver 185.43.135.1' > "$(PKG_BUILD_DIR)/rootfs/etc/resolv.conf"
	mkdir -p "$(PKG_BUILD_DIR)/rootfs/tmp"
	mkdir -p "$(PKG_BUILD_DIR)/rootfs/var/lock"
	mkdir -p "$(PKG_BUILD_DIR)/busybox"
	echo "root::0:0:root:/:/bin/sh" > "$(PKG_BUILD_DIR)/rootfs/etc/passwd"
	echo "/bin/sh" > "$(PKG_BUILD_DIR)/rootfs/etc/shells"
	$(INSTALL_BIN) ./files/rescue.sh "$(PKG_BUILD_DIR)/rootfs/init"
	$(HOST_TAR) -C $(PKG_BUILD_DIR)/busybox --strip-components=1 -xjf $(DL_DIR)/$(PKG_SOURCE)
	mkdir -p "$(PKG_BUILD_DIR)"/rootfs//usr/share/udhcpc
	cp "$(PKG_BUILD_DIR)"/busybox/examples/udhcp/simple.script "$(PKG_BUILD_DIR)"/rootfs//usr/share/udhcpc/default.script
	chmod a+rx "$(PKG_BUILD_DIR)"/rootfs//usr/share/udhcpc/default.script
	cp ./files/rootfs.extra "$(PKG_BUILD_DIR)/rootfs.extra"
	cp ./files/$(DEVICE).its "$(PKG_BUILD_DIR)/rescue.its"
endef

define Build/Configure
	sed -i 's|^BORAD=.*|BOARD=$(DEVICE)|' "$(PKG_BUILD_DIR)/rootfs/init"
	# Kernel
	$(call Kernel/Configure)
	sed -i 's|=m$$$$|=n|' "$(LINUX_DIR)/.config"
	sed -i 's|^\(CONFIG_RD_.*\)=y|\1=n|' "$(LINUX_DIR)/.config"
	sed -i 's|^\(CONFIG_KERNEL_.*\)=y|\1=n|' "$(LINUX_DIR)/.config"
	sed -i 's|^\(CONFIG_NET_VENDOR_.*\)=y|\1=n|' "$(LINUX_DIR)/.config"
	sed -i 's|^.*\(CONFIG_NET_VENDOR_MARVELL\).*|CONFIG_NET_VENDOR_MARVELL=y|' "$(LINUX_DIR)/.config"
	sed -i 's|^\(CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE\)=y|# \1 is not set|' "$(LINUX_DIR)/.config"
	for cfg in \
	NET_DSA \
	NET_DSA_MV88E6XXX \
	NET_DSA_MV88E606 \
	NET_DSA_MV88E6XXX_GLOBAL2 \
	CGROUPS \
	CHECKPOINT_RESTORE \
	NAMESPACES \
	AIO \
	SWAP \
	CPU_IDLE \
	CPU_FREQ \
	HOTPLUG_CPU \
	UNMAP_KERNEL_AT_EL0 \
	HARDEN_BRANCH_PREDICTOR \
	ARM64_SSBD \
	HIGH_RES_TIMERS \
	TICK_CPU_ACCOUNTING \
	WIRELESS \
	WLAN \
	RFKILL \
	FW_LOADER \
	NETFILTER \
	NET_CLS_ROUTE4 \
	NET_CLS_FW \
	NET_CLS_U32 \
	NET_CLS_FLOW \
	ISDN \
	JFFS2_FS \
	SQUASHFS \
	INOTIFY_USER \
	FANOTIFY \
	OVERLAY_FS \
	TMPFS_XATTR \
	NETWORK_FILESYSTEMS \
	DEBUG_INFO \
	IKCONFIG \
	BINFMT_MISC \
	SECURITY_DMESG_RESTRICT \
	CRYPTO_HW \
	BPF \
	BPF_SYSCALL \
	HAVE_EBPF_JIT \
	NET_SCHED \
	NET_CLS \
	NET_CLS_ACT \
	NET_CLS_TCINDEX; do \
		sed -i "/^CONFIG_$$$$cfg=/ d" "$(LINUX_DIR)/.config"; \
		echo "CONFIG_$$$$cfg=n" >> "$(LINUX_DIR)/.config"; \
	done
	echo "CONFIG_BLK_DEV_INITRD=y" >> "$(LINUX_DIR)/.config"
	echo "CONFIG_INITRAMFS_COMPRESSION_NONE=y" >> "$(LINUX_DIR)/.config"
	echo "CONFIG_INITRAMFS_COMPRESSION_GZIP=n" >> "$(LINUX_DIR)/.config"
	echo "CONFIG_INITRAMFS_COMPRESSION_BZIP2=n" >> "$(LINUX_DIR)/.config"
	echo "CONFIG_INITRAMFS_COMPRESSION_LZMA=n" >> "$(LINUX_DIR)/.config"
	echo "CONFIG_INITRAMFS_COMPRESSION_LZO=n" >> "$(LINUX_DIR)/.config"
	echo "CONFIG_INITRAMFS_COMPRESSION_LZ4=n" >> "$(LINUX_DIR)/.config"
	echo "CONFIG_INITRAMFS_COMPRESSION_XZ=n" >> "$(LINUX_DIR)/.config"
	echo "CONFIG_INITRAMFS_COMPRESSION=\"\"" >> "$(LINUX_DIR)/.config"
	echo "CONFIG_RD_XZ=y" >> "$(LINUX_DIR)/.config"
	echo "CONFIG_VFAT_FS=y" >> "$(LINUX_DIR)/.config"
	echo "CONFIG_NTFS_FS=y" >> "$(LINUX_DIR)/.config"
	echo "CONFIG_CC_OPTIMIZE_FOR_SIZE=y" >> "$(LINUX_DIR)/.config"
	echo "CONFIG_CC_STACKPROTECTOR_NONE=y" >> "$(LINUX_DIR)/.config"
	echo "CONFIG_DEFAULT_HOSTNAME=\"turris-rescue\"" >> "$(LINUX_DIR)/.config"
	echo "CONFIG_INITRAMFS_SOURCE=\"$(PKG_BUILD_DIR)/rootfs $(PKG_BUILD_DIR)/rootfs.extra\"" >> "$(LINUX_DIR)/.config"
	echo "CONFIG_INITRAMFS_ROOT_UID=$$$$(id -u)" >> "$(LINUX_DIR)/.config"
	echo "CONFIG_INITRAMFS_ROOT_GID=$$$$(id -g)" >> "$(LINUX_DIR)/.config"
	echo "CONFIG_NLS_CODEPAGE_437=y" >> "$(LINUX_DIR)/.config"
	echo "CONFIG_NLS_ISO8859_1=y" >> "$(LINUX_DIR)/.config"
	# Busybox
	cp files/busybox-config $(PKG_BUILD_DIR)/busybox/.config
	$(MAKE) -C "$(PKG_BUILD_DIR)/busybox" $(MAKE_FLAGS) oldconfig
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
	$(KERNEL_MAKE) $(PKG_JOBS) silentoldconfig Image dtbs
	$(CP) "$(PKG_BUILD_DIR)"/rescue.its "$(PKG_BUILD_DIR)"/kernel/linux-$(LINUX_VERSION)/arch/$(LINUX_KARCH)/boot/rescue.its
endef

define Package/rescue-image/install
	install -d $(1)/usr/share/rescue-image
	cd "$(PKG_BUILD_DIR)"/kernel/linux-$(LINUX_VERSION)/arch/$(LINUX_KARCH)/boot/; ls; \
	PATH="$(PKG_BUILD_DIR)/kernel/linux-$(LINUX_VERSION)/scripts/dtc:$$PATH" \
	"$(STAGING_DIR_HOST)"/bin/mkimage -f rescue.its $(1)/usr/share/rescue-image/image.fit
	xz -k9 -F lzma $(1)/usr/share/rescue-image/image.fit
endef

$(eval $(call BuildPackage,rescue-image))

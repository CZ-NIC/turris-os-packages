#
## Copyright (C) 2016 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=rescue-image
PKG_VERSION:=3.0
PKG_RELEASE:=0
BB_VERSION:=1.30.1
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
DEVICE := $(subst _,,$(subst -,,$(subst turris,,$(subst DEVICE_cznic,,$(CONFIG_TARGET_PROFILE)))))
kernel_files=$(TOPDIR)/target/linux/$(BOARD)/files-$(KERNEL_PATCHVER)/. $(TOPDIR)/target/linux/generic/files/.

define Package/rescue-image
	TITLE:=rescue-image
	DEPENDS:=@(TARGET_mvebu_cortexa53_DEVICE_cznic-mox||TARGET_mvebu_cortexa9_DEVICE_cznic_turris-omnia)
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
	sed -i 's|^BOARD=.*|BOARD=$(DEVICE)|' "$(PKG_BUILD_DIR)/rootfs/init"
	# Kernel
	$(call Kernel/Configure)
	sed -i 's|=m$$$$|=n|' "$(LINUX_DIR)/.config"
	sed -i 's|^\(CONFIG_RD_.*\)=y|\1=n|' "$(LINUX_DIR)/.config"
	sed -i 's|^\(CONFIG_KERNEL_.*\)=y|\1=n|' "$(LINUX_DIR)/.config"
	sed -i 's|^\(CONFIG_NET_VENDOR_.*\)=y|\1=n|' "$(LINUX_DIR)/.config"
	sed -i 's|^.*\(CONFIG_NET_VENDOR_MARVELL\).*|CONFIG_NET_VENDOR_MARVELL=y|' "$(LINUX_DIR)/.config"
	sed -i 's|^\(CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE\)=y|# \1 is not set|' "$(LINUX_DIR)/.config"
	for cfg in \
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
	COREDUMP \
	VLAN_8021Q \
	JFFS2_FS \
	SQUASHFS \
	INOTIFY_USER \
	FANOTIFY \
	OVERLAY_FS \
	TMPFS_XATTR \
	NETWORK_FILESYSTEMS \
	DEBUG_INFO \
	BINFMT_MISC \
	SECURITY_DMESG_RESTRICT \
	CRYPTO_HW \
	BPF \
	ARM_APPENDED_DTB \
	ATAGS \
	CRASH_DUMP \
	PCI \
	ROOT_NFS \
	BPF_SYSCALL \
	HAVE_EBPF_JIT \
	ZSTD_COMPRESS \
	ZSTD_DECOMPRESS \
	CONFIG_SATA_MV \
	CONFIG_SATA_PMP \
	SATA_AHCI_PLATFORM \
	NET_SCHED \
	NET_CLS \
	NET_CLS_ACT \
	NET_EMATCH \
	NET_EMATCH_STACK \
	HAMRADIO \
	HAVE_IDE \
	AHCI_MVEBU \
	ATA_SFF \
	SATA_MV \
	NET_CADENCE \
	MISC_FILESYSTEMS \
	UBIFS_FS \
	UBIFS_FS_LZO \
	UBIFS_FS_ZLIB \
	UBIFS_FS_FORMAT4 \
	DEBUG_FS \
	DEBUG_KERNEL \
	ALLOW_DEV_COREDUMP \
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
	echo "CONFIG_VFAT_FS=y" >> "$(LINUX_DIR)/.config"
	echo "CONFIG_NTFS_FS=y" >> "$(LINUX_DIR)/.config"
	echo "CONFIG_CC_OPTIMIZE_FOR_SIZE=y" >> "$(LINUX_DIR)/.config"
	echo "CONFIG_CC_STACKPROTECTOR_NONE=y" >> "$(LINUX_DIR)/.config"
	echo "CONFIG_DEFAULT_HOSTNAME=\"turris-rescue\"" >> "$(LINUX_DIR)/.config"
	echo "CONFIG_INITRAMFS_SOURCE=\"\"" >> "$(LINUX_DIR)/.config"
	echo "CONFIG_INITRAMFS_ROOT_UID=$$$$(id -u)" >> "$(LINUX_DIR)/.config"
	echo "CONFIG_INITRAMFS_ROOT_GID=$$$$(id -g)" >> "$(LINUX_DIR)/.config"
	echo "CONFIG_NLS_CODEPAGE_437=y" >> "$(LINUX_DIR)/.config"
	echo "CONFIG_NLS_ISO8859_1=y" >> "$(LINUX_DIR)/.config"
	echo "CONFIG_IKCONFIG=n" >> "$(LINUX_DIR)/.config"
	echo "CONFIG_IKCONFIG_PROC=n" >> "$(LINUX_DIR)/.config"
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
	$(KERNEL_MAKE) $(PKG_JOBS) silentoldconfig $(KERNELNAME)
	cd $(LINUX_DIR); ./scripts/gen_initramfs_list.sh \
	-o "$(PKG_BUILD_DIR)"/kernel/linux-$(LINUX_VERSION)/arch/$(LINUX_KARCH)/boot/initrd.gz -u squash -g squash \
	"$(PKG_BUILD_DIR)/rootfs" "$(PKG_BUILD_DIR)/rootfs.extra"
	gzip -d "$(PKG_BUILD_DIR)"/kernel/linux-$(LINUX_VERSION)/arch/$(LINUX_KARCH)/boot/initrd.gz
	$(CP) "$(PKG_BUILD_DIR)"/rescue.its "$(PKG_BUILD_DIR)"/kernel/linux-$(LINUX_VERSION)/arch/$(LINUX_KARCH)/boot/rescue.its
endef

define Package/rescue-image/install
	install -d $(1)/usr/share/rescue-image
	cd "$(PKG_BUILD_DIR)"/kernel/linux-$(LINUX_VERSION)/arch/$(LINUX_KARCH)/boot/; ls; \
	PATH="$(PKG_BUILD_DIR)/kernel/linux-$(LINUX_VERSION)/scripts/dtc:$$PATH" \
	"$(STAGING_DIR_HOST)"/bin/mkimage -f rescue.its $(1)/usr/share/rescue-image/image.fit
	xz -k9 -F lzma $(1)/usr/share/rescue-image/image.fit
	[ "`stat -c '%s' $(1)/usr/share/rescue-image/image.fit.lzma`" -lt 7340032 ]
endef

$(eval $(call BuildPackage,rescue-image))

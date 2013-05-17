#
# Copyright (C) 2013 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=lxc
PKG_VERSION:=2013-05-16
PKG_RELEASE=$(PKG_SOURCE_VERSION)

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=git://lxc.git.sourceforge.net/gitroot/lxc/lxc
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=e9831f83532184caa119f830eee54728084444ba
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.gz

PKG_BUILD_PARALLEL:=1
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

LXC_APPLETS += \
	attach cgroup checkpoint console execute freeze info kill monitor \
	restart start stop unfreeze unshare wait

LXC_SCRIPTS += \
	checkconfig clone create destroy ls netstat ps shutdown version

DEPENDS_APPLETS = +libpthread +libcap +liblxc

DEPENDS_checkpoint = @BROKEN
DEPENDS_clone = @BROKEN
DEPENDS_create = @BROKEN
DEPENDS_destroy = @BROKEN
DEPENDS_restart = @BROKEN
DEPENDS_shutdown = +lxc-info +lxc-wait @BROKEN


define Package/lxc/Default
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=LXC userspace tools
  URL:=http://lxc.sourceforge.net/
  MAINTAINER:=Luka Perkov <luka@openwrt.org>
endef

define Package/lxc
  $(call Package/lxc/Default)
  DEPENDS:= \
	+lxc-common +lxc-hooks +lxc-init +lxc-templates +liblxc \
	$(foreach u,$(LXC_APPLETS),+lxc-$(u)) $(foreach u,$(LXC_SCRIPTS),+lxc-$(u))
endef

define Package/lxc/description
 LXC is the userspace control package for Linux Containers, a lightweight
 virtual system mechanism sometimes described as "chroot on steroids".
endef

define Package/lxc-common
  $(call Package/lxc/Default)
  TITLE:=LXC common files
endef

define Package/lxc-hooks
  $(call Package/lxc/Default)
  TITLE:=LXC virtual machine hooks
endef

define Package/lxc-init
  $(call Package/lxc/Default)
  TITLE:=Utility lxc-init from the LXC userspace tools
  DEPENDS:= $(DEPENDS_APPLETS)
endef

define Package/lxc-templates
  $(call Package/lxc/Default)
  TITLE:=LXC virtual machine templates
  DEPENDS:= @BROKEN
endef

define Package/liblxc
  $(call Package/lxc/Default)
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=LXC userspace library
  DEPENDS:= +libpthread +libcap
endef


CONFIGURE_ARGS+= \
	--disable-apparmor \
	--disable-doc \
	--disable-examples \
	--disable-seccomp

define Build/Configure
	( cd $(PKG_BUILD_DIR); ./autogen.sh );
	$(call Build/Configure/Default)
endef


define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include/lxc/
	$(CP) \
		$(PKG_INSTALL_DIR)/usr/include/lxc/* \
		$(1)/usr/include/lxc/

	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) \
		$(PKG_INSTALL_DIR)/usr/lib/liblxc.so* \
		$(1)/usr/lib/

	$(INSTALL_DIR) $(1)/usr/lib/pkgconfig
	$(CP) \
		$(PKG_INSTALL_DIR)/usr/lib/pkgconfig/lxc.pc \
		$(1)/usr/lib/pkgconfig/
endef


define Package/lxc/install
	true
endef

define Package/lxc-common/conffiles
/etc/lxc/default.conf
/etc/lxc/lxc.conf
endef

define Package/lxc-common/install
	$(INSTALL_DIR) $(1)/usr/lib/lxc/rootfs
	$(CP) \
		$(PKG_INSTALL_DIR)/usr/lib/lxc/rootfs/README \
		$(1)/usr/lib/lxc/rootfs/

	$(INSTALL_DIR) $(1)/usr/share/lxc
	$(CP) \
		$(PKG_INSTALL_DIR)/usr/share/lxc/lxc.functions \
		$(1)/usr/share/lxc/

	$(INSTALL_DIR) $(1)/etc/lxc/
	$(CP) \
		$(PKG_INSTALL_DIR)/etc/lxc/default.conf \
		$(1)/etc/lxc/
endef

define Package/lxc-init/install
	$(INSTALL_DIR) $(1)/usr/lib/lxc
	$(CP) \
		$(PKG_INSTALL_DIR)/usr/lib/lxc/lxc-init \
		$(1)/usr/lib/lxc/
endef

define Package/lxc-hooks/install
	$(INSTALL_DIR) $(1)/usr/share/lxc/hooks
	$(CP) \
		$(PKG_INSTALL_DIR)/usr/share/lxc/hooks/mountcgroups \
		$(1)/usr/share/lxc/hooks/
	$(CP) \
		$(PKG_INSTALL_DIR)/usr/share/lxc/hooks/mountecryptfsroot \
		$(1)/usr/share/lxc/hooks/
endef

define Package/lxc-templates/install
	$(INSTALL_DIR) $(1)/usr/share/lxc/templates/
	$(CP) \
		$(PKG_INSTALL_DIR)/usr/share/lxc/templates/lxc-* \
		$(1)/usr/share/lxc/templates/
endef

define Package/liblxc/install
	$(INSTALL_DIR) $(1)/usr/lib/
	$(CP) \
		$(PKG_INSTALL_DIR)/usr/lib/liblxc.so* \
		$(1)/usr/lib/
endef


define GenPlugin
  define Package/lxc-$(1)
    $(call Package/lxc/Default)
    TITLE:=Utility lxc-$(1) from the LXC userspace tools
    DEPENDS:= +lxc-common $(2) $(DEPENDS_$(1))
  endef

  define Package/lxc-$(1)/install
	$(INSTALL_DIR) $$(1)/usr/bin
	$(INSTALL_BIN) \
		$(PKG_INSTALL_DIR)/usr/bin/lxc-$(1) \
		$$(1)/usr/bin/
  endef

  $$(eval $$(call BuildPackage,lxc-$(1)))
endef


$(eval $(call BuildPackage,lxc))
$(eval $(call BuildPackage,lxc-common))
$(eval $(call BuildPackage,lxc-hooks))
$(eval $(call BuildPackage,lxc-init))
$(eval $(call BuildPackage,lxc-templates))
$(eval $(call BuildPackage,liblxc))
$(foreach u,$(LXC_APPLETS),$(eval $(call GenPlugin,$(u),$(DEPENDS_APPLETS))))
$(foreach u,$(LXC_SCRIPTS),$(eval $(call GenPlugin,$(u))))

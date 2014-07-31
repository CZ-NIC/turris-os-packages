 
# Copyright (C) 2009-2012 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
#
include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=nfacct
PKG_VERSION:=1.0.1
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=\
	http://netfilter.org/projects/${PKG_NAME}/files/ \
	ftp://ftp.netfilter.org/pub/${PKG_NAME}/
PKG_MD5SUM:=992e863409d144350dbc8f0554a0f478

PKG_MAINTAINER:=Stepan Henek <stepan.henek@nic.cz>

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/nfacct
$(call Package/nfacct/Default)
  SECTION:=net
  CATEGORY:=Network
  DEPENDS+=+libnetfilter-acct +libmnl +iptables-mod-nfacct
  TITLE:=command line tool to create/retrieve/delete accounting objects
  URL:=http://netfilter.org/projects/nfacct/index.html
endef


define Package/libnetfilter-acct/description
 command line tool to create/retrieve/delete accounting objects
endef


define Build/Compile
	$(call Build/Compile/Default)
endef

define Package/nfacct/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(CP) $(PKG_INSTALL_DIR)/usr/sbin/nfacct $(1)/usr/sbin/
endef


$(eval $(call BuildPackage,nfacct))

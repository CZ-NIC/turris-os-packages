include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=nfacct
PKG_VERSION:=1.0.2
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=https://netfilter.org/projects/nfacct/files/
PKG_HASH:=ecff2218754be318bce3c3a5d1775bab93bf4168b2c4aac465785de5655fbd69

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-2.0-or-later
PKG_LICENSE_FILES:=COPYING

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/nfacct
  SECTION:=net
  CATEGORY:=Network
  TITLE:=netfilter accounting object tool
  URL:=https://netfilter.org/projects/nfacct/index.html
  DEPENDS:=+libnetfilter-acct +libmnl +iptables-mod-nfacct
endef

define Package/nfacct/description
  nfacct is the command line tool to create/retrieve/delete accounting objects.
endef

define Package/nfacct/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(CP) $(PKG_INSTALL_DIR)/usr/sbin/nfacct $(1)/usr/sbin/
endef


$(eval $(call BuildPackage,nfacct))

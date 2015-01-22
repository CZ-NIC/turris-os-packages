#
# Copyright (C) 2010 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk
PKG_NAME:=mitmproxy
PKG_VERSION:=0.1
PKG_RELEASE:=1
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/labs/mitmproxy.git
PKG_SOURCE:=$(PKG_NAME).tar.gz
PKG_SOURCE_VERSION:=29b1e35d3de8a45a399f9152d6952089ca81692d
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_MAINTAINER:=Ondrej Mikle <ondrej.mikle@nic.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python-package.mk)

define Package/mitmproxy
  SECTION:=net
  CATEGORY:=Network
  TITLE:=mitmproxy
  URL:=https://github.com/saironiq/mitmproxy
  DEPENDS:=+python +python-twisted +python-crypto
  MAINTAINER:=Ondrej Mikle <ondrej.mikle@nic.cz>
endef

define Package/mitmproxy/description
Mitmproxy is set of man-in-the-middle proxies to intercept SSH, SSL, HTTP, SNMP and telnet.
endef

define Build/Compile
	$(call Build/Compile/PyMod,,install --prefix=/usr --root=$(PKG_INSTALL_DIR))
endef

define Package/mitmproxy/install
	$(INSTALL_DIR) $(1)
	$(CP) \
		$(PKG_INSTALL_DIR)/* \
		$(1)
endef

$(eval $(call BuildPackage,mitmproxy))

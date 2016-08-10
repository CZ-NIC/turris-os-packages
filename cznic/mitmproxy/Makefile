#
# Copyright (C) 2010 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk
PKG_NAME:=mitmproxy
PKG_VERSION:=0.4.1
PKG_RELEASE:=3
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/labs/mitmproxy.git
PKG_SOURCE:=$(PKG_NAME).tar.gz
PKG_SOURCE_VERSION:=f5f87fb423f69e9fe14daa835b3708d1bde21769
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

define Package/mitmproxy/postinst
#!/bin/sh
if [ -z "$${IPKG_INSTROOT}" ]; then
	python /usr/bin/mitm_turris_config.py
	rm -rf /etc/mitmkeys
	echo Generating keys...
	/usr/bin/mitmkeygen
	echo Starting...
	/etc/init.d/mitmproxy_wrapper start
	echo Enabling at startup
	/etc/init.d/mitmproxy_wrapper enable
fi
true
endef

define Package/mitmproxy/prerm
	/etc/init.d/mitmproxy_wrapper stop || true
	/etc/init.d/mitmproxy_wrapper disable || true
endef

$(eval $(call BuildPackage,mitmproxy))

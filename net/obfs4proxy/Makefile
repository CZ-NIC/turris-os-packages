#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=obfs4proxy
PKG_VERSION:=0.0.7
PKG_RELEASE:=2

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/Yawning/obfs4.git
PKG_SOURCE_VERSION:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)


PKG_BUILD_DEPENDS:=go/host
PKG_LICENSE:=GPL-3.0
PKG_MAINTAINER:=Jan Pavlinec <jan.pavlinec@nic.cz>

GO_SRC_DIR:=$(PKG_BUILD_DIR)/obfs4proxy/
include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/package/devel/go/files/go-package.mk

define Package/obfs4proxy
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=IP Addresses and Names
	TITLE:=obfs4proxy
	URL:=https://github.com/Yawning/obfs4
endef

define Package/$(PKG_NAME)/description
  Pluggable Transports (PT) transform the Tor traffic flow between the client and the bridge.
  https://trac.torproject.org/projects/tor/wiki/doc/PluggableTransports/obfs4proxy
endef

define Build/Compile
	$(call Build/Compile/Go)
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/bin/
	$(CP) $$(PKG_BUILD_DIR)/obfs4proxy/obfs4proxy $(1)/usr/bin/obfs4proxy
endef

$(eval $(call BuildPackage,obfs4proxy))


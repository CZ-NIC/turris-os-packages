#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=meek
PKG_VERSION:=f5726d12dca8135144433c93a16500b05d742f88
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/arlolra/meek.git
PKG_SOURCE_VERSION:=$(PKG_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)


PKG_BUILD_DEPENDS:=go/host
PKG_LICENSE:=GPL-3.0
PKG_MAINTAINER:=Jan Pavlinec <jan.pavlinec@nic.cz>

GO_SRC_DIR:=$(PKG_BUILD_DIR)/meek-client/
include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/package/devel/go/files/go-package.mk

define Package/meek
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=IP Addresses and Names
	TITLE:=meek
	URL:=https://github.com/arlolra/meek
endef

define Package/$(PKG_NAME)/description
 Meek is a blocking-resistant pluggable transport for Tor.
 https://trac.torproject.org/projects/tor/wiki/doc/meek
endef

define Build/Compile
	$(call Build/Compile/Go)
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/bin/
	$(CP) $$(PKG_BUILD_DIR)/meek-client/meek-client $(1)/usr/bin/meek-client
endef

$(eval $(call BuildPackage,meek))

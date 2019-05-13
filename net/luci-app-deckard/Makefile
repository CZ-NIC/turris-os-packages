
include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-deckard
PKG_VERSION:=1.0
PKG_RELEASE:=1

PKG_LICENSE:=GPL-3.0

include $(INCLUDE_DIR)/package.mk

define Package/luci-app-deckard
  SECTION:=luci
  CATEGORY:=LuCI
  SUBMENU:=3. Applications
  TITLE:=Encrypted near-zero-conf mesh routing protocol
  URL:=https://gitlab.labs.nic.cz/knot/deckard
  MAINTAINER:=Jan Pavlinec <jan.pavlinec@nic.cz>
  DEPENDS:=+luci-base +deckard
endef

define Package/luci-app-deckard/description
  LuCI interface for deckard frameowrk
endef

define Build/Compile
endef

define Package/luci-app-deckard/install
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci
	$(CP) ./luasrc/* $(1)/usr/lib/lua/luci
	$(INSTALL_DIR) $(1)/usr/libexec/rpcd/
	$(CP) ./files/xml_parser.py  $(1)/usr/libexec/rpcd/
	$(INSTALL_DIR) $(1)/etc/config
	$(CP) ./files/cbi_file  $(1)/etc/config
endef

$(eval $(call BuildPackage,luci-app-deckard))

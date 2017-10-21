include $(TOPDIR)/rules.mk

PKG_NAME:=sshpass
PKG_VERSION:=1.06
PKG_RELEASE:=0

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=@SF/sshpass
PKG_MD5SUM:=f59695e3b9761fb51be7d795819421f9

PKG_LICENSE:=GPL-2.0
PKG_MAINTAINER:=CZ.NIC <packaging@nic.cz>

include $(INCLUDE_DIR)/package.mk

define Package/sshpass
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=Non-interactive ssh password auth
  URL:=https://sshpass.sourceforge.io/
endef

define Package/sshpass/description
	Sshpass is a tool for non-interactivly performing password authentication
  with SSH's so called "interactive keyboard password authentication". Most user
  should use SSH's more secure public key authentiaction instead.
endef

define Package/sshpass/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/sshpass $(1)/usr/bin
endef

$(eval $(call BuildPackage,sshpass))

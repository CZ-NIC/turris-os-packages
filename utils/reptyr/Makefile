include $(TOPDIR)/rules.mk

PKG_NAME:=reptyr
PKG_VERSION:=0.7.0
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://github.com/nelhage/reptyr/archive/
PKG_HASH:=b1c539f4c8e695d575f5d4593e64a3a04d63b0f0c5d34e6c735fd28e365d4983

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_NAME)-$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=COPYING

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/reptyr
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=Tool for reparenting running programs
  URL:=https://github.com/nelhage/reptyr
endef

define Package/reptyr/description
  reptyr is a utility for taking an existing running program and attaching it
  to a new terminal. Started a long-running process over ssh, but have to
  leave and don't want to interrupt it? Just start a screen, use reptyr to
  grab it, and then kill the ssh session and head on home.
endef

MAKE_FLAGS+= \
	PREFIX=/usr

define Package/reptyr/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/reptyr $(1)/usr/bin/
endef

$(eval $(call BuildPackage,reptyr))

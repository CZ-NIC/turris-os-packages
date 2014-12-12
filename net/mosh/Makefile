#
# Copyright (C) 2011-2013 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=mosh
PKG_VERSION:=1.2.4
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://mosh.mit.edu/
PKG_MD5SUM:=c2d918f4d91fdc32546e2e089f9281b2

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/mosh/Default
	SECTION:=utils
	CATEGORY:=Utilities
	TITLE:=Mosh mobile shell
	DEPENDS:=+libncursesw +libopenssl +protobuf
	URL:=http://mosh.mit.edu/
endef

define Package/mosh-client
$(call Package/mosh/Default)
 TITLE+= (client)
endef

define Package/mosh-server
$(call Package/mosh/Default)
 TITLE+= (client)
endef

define Package/mosh-full
$(call Package/mosh/Default)
 TITLE+= (client)
 DEPENDS:= \
    +mosh-client \
    +mosh-server \
    +perlbase-essential \
    +perlbase-socket \
    +perlbase-xsloader \
    +perlbase-getopt \
    +perlbase-errno \
    +perlbase-config \
    +perlbase-io \
    +perlbase-symbol \
    +perlbase-selectsaver \
    +perlbase-posix \
    +perlbase-autoloader \
    +perlbase-fcntl \
    +perlbase-tie
endef


define Package/mosh/Default/description
 Mosh is a remote terminal application that allows roaming, supports
 intermittent connectivity, and provides intelligent local echo and line
 editing of user keystrokes.
endef

define Package/mosh-client/description
$(call Package/mosh/Default/description)
 This is a mosh client.
endef

define Package/mosh-server/description
$(call Package/mosh/Default/description)
 This is a mosh server.
endef

define Package/mosh-full/description
$(call Package/mosh/Default/description)
 This is a full package with perl wrapper script
endef


CONFIGURE_ARGS += \
	--with-curses=$(STAGING_DIR)/usr \
	--disable-hardening \
	--without-utempter \

define Package/mosh-client/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/mosh-client $(1)/usr/bin/
endef

define Package/mosh-server/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/mosh-server $(1)/usr/bin/
endef

define Package/mosh-full/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/mosh $(1)/usr/bin/
endef

$(eval $(call BuildPackage,mosh-client))
$(eval $(call BuildPackage,mosh-server))
$(eval $(call BuildPackage,mosh-full))

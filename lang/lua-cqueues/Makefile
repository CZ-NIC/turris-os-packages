include $(TOPDIR)/rules.mk

PKG_NAME:=lua-cqueues
PKG_VERSION:=20200726
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/wahern/cqueues/tar.gz/rel-$(PKG_VERSION)?
PKG_HASH:=9e112edd246da5cfca264314b70325a0b63665cb87a00e45ee3ae4f194000d52

PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

PKG_BUILD_DIR:=$(BUILD_DIR)/cqueues-rel-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/lua-cqueues
  SUBMENU:=Lua
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=Lua CQueues
  URL:=http://25thandclement.com/~william/projects/cqueues.html
  DEPENDS:=+lua +libopenssl +librt +libpthread
endef

define Package/lua-cqueues/description
  Continuation Queues: Embeddable asynchronous networking, threading, and
  notification framework for Lua on Unix.
endef

define Build/Configure
endef

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR)/ \
		LUA_APIS="5.1" \
		ALL_LDFLAGS="$(TARGET_LDFLAGS)" \
		CC="$(TARGET_CC) $(TARGET_CFLAGS) $(TARGET_CPPFLAGS) -fPIC -std=gnu99" \
		LD="$(TARGET_CROSS)ld -shared" \
		all5.1
endef

define Package/lua-cqueues/install
	$(INSTALL_DIR) $(1)/usr/share/lua
	$(MAKE) -C $(PKG_BUILD_DIR)/ \
		lua51path=$(1)/usr/share/lua lua51cpath=$(1)/usr/share/lua \
		install5.1
	mv $(1)/usr/share/lua/_cqueues.so $(1)/usr/share/lua/cqueues.so
endef

$(eval $(call BuildPackage,lua-cqueues))

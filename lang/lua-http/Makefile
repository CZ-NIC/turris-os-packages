include $(TOPDIR)/rules.mk

PKG_NAME:=lua-http
PKG_VERSION:=0.4
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
#PKG_SOURCE_URL:=https://codeload.github.com/wahern/cqueues/tar.gz/rel-$(PKG_VERSION)?
PKG_SOURCE_URL:=https://codeload.github.com/daurnimator/lua-http/tar.gz/v$(PKG_VERSION)?

#https://github.com/daurnimator/lua-http/releases/tag/v0.4

PKG_HASH:=d2e3cb9bc04cab70ac4f19351bc74b0dcd8b16cfc2563aa77256eb3a43b3b9e0

PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

#PKG_BUILD_DIR:=$(BUILD_DIR)/cqueues-rel-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/lua-http
  SUBMENU:=Lua
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=Lua  http
  URL:=http://25thandclement.com/~william/projects/cqueues.html
  DEPENDS:=+lua +libopenssl +librt +libpthread
endef

define Package/lua-http/description
  Continuation Queues: Embeddable asynchronous networking, threading, and
  notification framework for Lua on Unix.
endef

#define Build/Configure
#endef

TARGET_CFLAGS += \
	-I$(STAGING_DIR)/usr/include

MAKE_FLAGS += \
	FPIC="$(FPIC)" \
	CFLAGS="$(TARGET_CFLAGS)" \
	LDFLAGS="$(TARGET_LDFLAGS)"

#define Build/Compile
#	$(MAKE) -C $(PKG_BUILD_DIR)/ \
#		LUA_APIS="5.1" \
#		ALL_LDFLAGS="$(TARGET_LDFLAGS)" \
#		CC="$(TARGET_CC) $(TARGET_CFLAGS) $(TARGET_CPPFLAGS) -fPIC -std=gnu99" \
#		LD="$(TARGET_CROSS)ld -shared" \
#		all5.1
#endef


define Build/Compile
  cd $(PKG_BUILD_DIR) && \
  luarocks install --only-deps http-0.4-0.rockspec && \
  luarocks make --tree build http-0.4-0.rockspec \
    CC="$(TARGET_CC)" LD="$(TARGET_CC)"
endef

# luarocks make --pack-binary-rock http-0.4-0.rockspec \
#$ luarocks install --only-deps http-scm-0.rockspec

define Package/lua-http/install
	$(INSTALL_DIR) $(1)/usr/
	#$(INSTALL_DIR) $(1)/usr/share/lua
	cp -r $(PKG_BUILD_DIR)/build/* $(1)/usr/
	#$(MAKE) -C $(PKG_BUILD_DIR)/ \
	#	lua51path=$(1)/usr/share/lua lua51cpath=$(1)/usr/share/lua \
	#	install5.1
	#mv $(1)/usr/share/lua/_cqueues.so $(1)/usr/share/lua/cqueues.so
endef

$(eval $(call BuildPackage,lua-http))

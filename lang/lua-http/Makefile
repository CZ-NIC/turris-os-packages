include $(TOPDIR)/rules.mk

PKG_NAME:=lua-http
PKG_VERSION:=0.4
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/daurnimator/lua-http/tar.gz/v$(PKG_VERSION)?
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
  TITLE:=Lua http
  URL:=https://daurnimator.github.io/lua-http/
  DEPENDS:=+lua +libopenssl +librt +libpthread
endef

define Package/lua-http/description
  lua-http is an performant, capable HTTP and WebSocket library for Lua 5.1, 5.2, 5.3 and LuaJIT.
endef

TARGET_CFLAGS += \
	-I$(STAGING_DIR)/usr/include

MAKE_FLAGS += \
	FPIC="$(FPIC)" \
	CFLAGS="$(TARGET_CFLAGS)" \
	LDFLAGS="$(TARGET_LDFLAGS)"

define Build/Compile
  cd $(PKG_BUILD_DIR) && \
  luarocks install --only-deps http-0.4-0.rockspec && \
  luarocks make --tree build http-0.4-0.rockspec \
    CC="$(TARGET_CC)" LD="$(TARGET_CC)"
endef

define Package/lua-http/install
	$(INSTALL_DIR) $(1)/usr/
	cp -r $(PKG_BUILD_DIR)/build/* $(1)/usr/
endef

$(eval $(call BuildPackage,lua-http))

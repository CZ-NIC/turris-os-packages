include $(TOPDIR)/rules.mk

PKG_NAME:=luajit
PKG_VERSION:=2.2.0
PKG_RELEASE:=2

PKG_SOURCE:=moonjit-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/moonjit/moonjit/tar.gz/$(PKG_VERSION)?
PKG_HASH:=83deb2c880488dfe7dd8ebf09e3b1e7613ef4b8420de53de6f712f01aabca2b6
PKG_BUILD_DIR:=$(BUILD_DIR)/moonjit-$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=COPYRIGHT

PKG_USE_MIPS16:=0
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/host-build.mk

define Package/luajit
  SUBMENU:=Lua
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=LuaJIT (MoonJIT)
  URL:=https://github.com/moonjit/moonjit
  DEPENDS:=@(i386||x86_64||arm||armeb||aarch64||mips||mipsel)
  ALTERNATIVES:=300:/usr/bin/luajit:/usr/bin/moonjit
endef

define Package/luajit/description
 LuaJIT is a Just-In-Time (JIT) compiler for the Lua programming language. *** Requires GCC Multilib on host system to build! ***
endef

ifeq ($(HOST_ARCH),x86_64)
  ifeq ($(CONFIG_ARCH_64BIT),)
    HOST_BITS := -m32
  endif
endif

MAKE_VARS =

MAKE_FLAGS = \
	DPREFIX=$(PKG_INSTALL_DIR)/usr \
	PREFIX=/usr \
	CROSS="$(TARGET_CROSS)" \
	TARGET_CFLAGS="$(TARGET_CFLAGS)" \
	TARGET_LDFLAGS="$(TARGET_LDFLAGS)" \
	TARGET_SYS=Linux \
	HOST_CC="$(HOSTCC)" \
	HOST_CFLAGS="$(HOST_CFLAGS) $(HOST_BITS)" \
	HOST_LDFLAGS="$(HOST_LDFLAGS) $(HOST_BITS)"

MAKE_INSTALL_FLAGS =  \
	DPREFIX=$(PKG_INSTALL_DIR)/usr \
	PREFIX=/usr \
	TARGET_SYS=Linux \

HOST_MAKE_FLAGS = \
	DPREFIX=$(STAGING_DIR_HOSTPKG) \
	TARGET_CFLAGS="$(HOST_CFLAGS)" \
	TARGET_LDFLAGS="$(HOST_LDFLAGS)"

define Package/luajit/install
	$(INSTALL_DIR) $(1)/usr/lib/
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/*.so* $(1)/usr/lib/
	$(INSTALL_DIR) $(1)/usr/bin
	$(CP) $(PKG_INSTALL_DIR)/usr/bin/* $(1)/usr/bin/
	$(LN) moonjit-$(PKG_VERSION) $(1)/usr/bin/moonjit
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include/moonjit-2.2
	$(CP) $(PKG_INSTALL_DIR)/usr/include/moonjit-2.2/*.{h,hpp} $(1)/usr/include/moonjit-2.2
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/*.{a,so*} $(1)/usr/lib/
	$(INSTALL_DIR) $(1)/usr/lib/pkgconfig
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/pkgconfig/luajit.pc $(1)/usr/lib/pkgconfig/
	$(INSTALL_DIR) $(1)/usr/bin
	$(CP) $(PKG_INSTALL_DIR)/usr/bin/moonjit-$(PKG_VERSION) $(1)/usr/bin/moonjit
endef

$(eval $(call HostBuild,luajit))
$(eval $(call BuildPackage,luajit))

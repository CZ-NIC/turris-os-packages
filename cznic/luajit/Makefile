#
# Copyright (C) 2010 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#


include $(TOPDIR)/rules.mk

PKG_NAME:=LuaJIT
PKG_VERSION:=2.0.5
PKG_RELEASE:=1
PKG_SOURCE_URL:=http://luajit.org/download
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_MD5SUM:=874b1f8297c697821f561f9b73b57ffd419ed8f4278c82e05b48806d30c1e979
include $(INCLUDE_DIR)/package.mk

define Package/luajit
  SUBMENU:=Lua
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=LuaJIT
  URL:=http://luajit.org
endef

define Package/luajit/description
 LuaJIT is a Just-In-Time Compiler for the Lua* programming language.
 LuaJIT implements the full set of language features defined by Lua 5.1.
 The virtual machine (VM) is API- and ABI-compatible to the standard Lua interpreter and can be deployed as a drop-in replacement.
 LuaJIT offers more performance, at the expense of portability.
 It currently runs on all popular operating systems based on x86 or x64 CPUs (Linux, Windows, OSX etc.) or embedded systems based on ARM (Android, iOS), PPC or MIPS CPUs.
 Other platforms will be supported in the future, based on user demand and sponsoring.
endef

define Build/Compile
#	$(call Build/Compile/Default)
	$(MAKE) -C $(PKG_BUILD_DIR) HOST_CC="gcc -m32" CROSS=$(TARGET_CROSS) TARGET_CFLAGS="$(TARGET_CFLAGS)" HOST_CFLAGS="$(HOST_CFLAGS)" TARGET_LDFLAGS="$(TARGET_LDFLAGS)" HOST_LDFLAGS="$(HOST_LDFLAGS)" DESTDIR="$(PKG_INSTALL_DIR)" PREFIX=/usr INSTALL_LMOD="$(PKG_INSTALL_DIR)/usr/share/lua" INSTALL_CMOD="$(PKG_INSTALL_DIR)/usr/share/lua" amalg
	$(MAKE) -C $(PKG_BUILD_DIR) CROSS=$(TARGET_CROSS) TARGET_CFLAGS="$(TARGET_CFLAGS)" HOST_CFLAGS="$(HOST_CFLAGS)" TARGET_LDFLAGS="$(TARGET_LDFLAGS)" HOST_LDFLAGS="$(HOST_LDFLAGS)" DESTDIR="$(PKG_INSTALL_DIR)" PREFIX=/usr INSTALL_LMOD="$(PKG_INSTALL_DIR)/usr/share/lua" INSTALL_CMOD="$(PKG_INSTALL_DIR)/usr/share/lua" install
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/{lib,include}
	$(INSTALL_DIR) $(1)/usr/lib/pkgconfig
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libluajit* $(1)/usr/lib/
	(cd $(1)/usr/lib ;ln -s libluajit-5.1.so libluajit.so)
	$(CP) $(PKG_INSTALL_DIR)/usr/include/* $(1)/usr/include/
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/pkgconfig/luajit.pc $(1)/usr/lib/pkgconfig/luajit.pc
endef

define Package/luajit/install
	$(INSTALL_DIR) $(1)/usr/{lib,bin,share}
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libluajit*so* $(1)/usr/lib/
	$(LN) libluajit-5.1.so.$(PKG_VERSION) $(1)/usr/lib/libluajit-5.1.so.2
	$(CP) $(PKG_INSTALL_DIR)/usr/bin/* $(1)/usr/bin/
	$(CP) $(PKG_INSTALL_DIR)/usr/share/luajit* $(1)/usr/share/
endef

$(eval $(call BuildPackage,luajit))

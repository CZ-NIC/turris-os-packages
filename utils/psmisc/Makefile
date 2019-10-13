include $(TOPDIR)/rules.mk

PKG_NAME:=psmisc
PKG_VERSION:=23.2
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=@SF/psmisc
PKG_HASH:=4b7cbffdc9373474da49b85dc3457ae511c43dc7fa7d94513fe06f89dcb87880

PKG_MAINTAINER:=Josef Schlehofer <pepe.schlehofer@gmail.com>
PKG_LICENSE:=GPL-2.0-or-later
PKG_LICENSE_FILES:=COPYING

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/psmisc
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=proc utilities
  URL:=https://gitlab.com/psmisc/psmisc/
  DEPENDS:=+libncurses
endef

define Package/psmisc/description
  psmisc is a set of additional small useful utilities that use
  the proc filesystem like fuser, killall, prtstat, pslog,
  pstree, and peekfd
endef

CONFIGURE_ARGS += \
	--disable-harden-flags

MAKE_FLAGS += \
	CFLAGS="$(TARGET_CFLAGS)" \
	CPPFLAGS="$(TARGET_CPPFLAGS)" \
	LDFLAGS="$(TARGET_LDFLAGS)"

define Package/psmisc/preinst
#!/bin/sh
if [ -e $${IPKG_INSTROOT}/usr/bin/killall ]; then
  rm $${IPKG_INSTROOT}/usr/bin/killall;
fi
endef

define Package/psmisc/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) \
		$(PKG_INSTALL_DIR)/usr/bin/{fuser,killall,prtstat,pstree} \
		$(1)/usr/bin/
endef

define Package/psmisc/postrm
#!/bin/sh
ln -sf ../../bin/busybox $${IPKG_INSTROOT}/usr/bin/killall
$${IPKG_INSTROOT}/usr/bin/killall 2>&1 | grep 'applet not found' > /dev/null 2>&1 && rm $${IPKG_INSTROOT}/usr/bin/killall
exit 0
endef

$(eval $(call BuildPackage,psmisc))

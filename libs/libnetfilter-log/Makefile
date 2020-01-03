include $(TOPDIR)/rules.mk

PKG_NAME:=libnetfilter-log
PKG_VERSION:=1.0.1
PKG_RELEASE:=2

PKG_SOURCE:=libnetfilter_log-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=https://netfilter.org/projects/libnetfilter_log/files/
PKG_HASH:=74e0fe75753dba3ac114531b5e73240452c789a3f3adccf5c51217da1d933b21

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/libnetfilter-log
  SECTION:=libs
  CATEGORY:=Libraries
  DEPENDS:=+libnfnetlink +kmod-nfnetlink-log +kmod-ipt-nflog
  TITLE:=Netfilter netlink-log library
  URL:=https://netfilter.org/projects/libnetfilter_log/
endef

define Package/libnetfilter-log/description
  libnetfilter_log is a userspace library providing interface to
  packets that have been logged by the kernel packet filter.
endef

TARGET_CFLAGS += $(FPIC)

CONFIGURE_ARGS += \
	--enable-static \
	--enable-shared \

CONFIGURE_VARS += \
	LIBNFNETLINK_CFLAGS="$(TARGET_CPPFLAGS)" \
	LIBNFNETLINK_LIBS="$(TARGET_LDFLAGS)"

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include/libnetfilter_log
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/usr/include/libnetfilter_log/*.h $(1)/usr/include/libnetfilter_log/

	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libnetfilter_log*.{so*,a,la} $(1)/usr/lib/

	$(INSTALL_DIR) $(1)/usr/lib/pkgconfig
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/usr/lib/pkgconfig/libnetfilter_log.pc $(1)/usr/lib/pkgconfig/
endef

define Package/libnetfilter-log/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libnetfilter_log*.so.* $(1)/usr/lib/
endef

$(eval $(call BuildPackage,libnetfilter-log))

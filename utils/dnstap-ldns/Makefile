
include $(TOPDIR)/rules.mk

PKG_NAME:=dnstap-ldns
PKG_VERSION:=0.2.0
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/dnstap/dnstap-ldns/tar.gz/v$(PKG_VERSION)?
PKG_MD5SUM:=a0dc0526cb1eb1a3cef4e49b1b0b4c6ff98c291d7ba57b746e35e13c84982fb3


PKG_FIXUP:=autoreconf
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/autotools.mk
include $(INCLUDE_DIR)/nls.mk

PKG_BUILD_DEPENDS:=protobuf-c/host

define Package/dnstap-ldns
  SECTION:=utils
  CATEGORY:=Utilities
  DEPENDS:=+libldns +fstrm +libprotobuf-c +protobuf
  TITLE:=dnstap decoding utility
  URL:=https://dnstap.info/
endef

define Package/dnstap-ldns/description
  dnstap decoding utility
endef


define Package/dnstap-ldns/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(CP) $(PKG_INSTALL_DIR)/usr/bin/dnstap-ldns $(1)/usr/bin/
endef

$(eval $(call BuildPackage,dnstap-ldns))

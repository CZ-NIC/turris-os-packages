#
# Copyright (C) 2019 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=reforis
PKG_VERSION:=0.3
PKG_RELEASE:=1
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/reforis
PKG_SOURCE_VERSION:=v$(PKG_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_BUILD_DIR:=$(BUILD_DIR)/$(BUILD_VARIANT)-$(PKG_NAME)-$(PKG_VERSION)
PKG_LICENSE:=GPL-3.0

PKG_BUILD_DEPENDS:=node/host

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

PKG_UNPACK:=$(HOST_TAR) -C $(PKG_BUILD_DIR) --strip-components=1 -xzf $(DL_DIR)/$(PKG_SOURCE)

define Package/reforis
	URL:=https://gitlab.labs.nic.cz/turris/reforis
	TITLE:=reforis
	DEPENDS:=\
		+python3-light \
		+python3-flask \
		+python3-flask-babel \
		+python3-flask-session
	MAINTAINER:=CZ.NIC <packaging@turris.cz>
	VARIANT=python3
endef

define Package/reforis/description
 Web administration interface for turris router.
endef

define Package/reforis/conffiles
/etc/config/reforis
endef

define Py3Package/reforis/filespec
+|$(PYTHON3_PKG_DIR)
endef

define Py3Package/reforis/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(CP) $(PKG_INSTALL_DIR)/usr/bin/* $(1)/usr/bin/

	$(INSTALL_DIR) $(1)/usr/share/turris-webapps
	$(INSTALL_DATA) ./files/01_reforis.conf $(1)/usr/share/turris-webapps/
	$(INSTALL_DIR) $(1)/www/webapps-icons
	$(INSTALL_DATA) ./files/reforis.jpg $(1)/www/webapps-icons

	$(INSTALL_DIR) $(1)/etc/lighttpd/conf.d/
	$(INSTALL_DATA) ./files/reforis-lighttpd.conf $(1)/etc/lighttpd/conf.d/reforis.conf

	$(INSTALL_DIR) $(1)/usr/libexec/reforis
	$(INSTALL_BIN) ./files/reforis-lighttpd-dynamic.sh $(1)/usr/libexec/reforis/lighttpd-dynamic
	$(SED) 's%/usr/lib/python...%/usr/lib/python$(PYTHON3_VERSION)%g' $(1)/usr/libexec/reforis/lighttpd-dynamic

	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_DATA) ./files/reforis.uci $(1)/etc/config/reforis

endef

define Package/reforis/postinst
[ -n "$$IPKG_INSTROOT" ] || {
	/etc/init.d/lighttpd enable
	/usr/bin/maintain-lighttpd-restart
}
endef

define Package/reforis/prerm
/usr/bin/maintain-lighttpd-restart
endef

$(eval $(call Py3Package,reforis))
$(eval $(call BuildPackage,reforis))
$(eval $(call BuildPackage,reforis-src))

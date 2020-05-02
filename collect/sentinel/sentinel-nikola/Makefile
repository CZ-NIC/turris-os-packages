#
## Copyright (C) 2018-2019 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=sentinel-nikola
PKG_VERSION:=2.0.1
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/sentinel/nikola.git
PKG_SOURCE_VERSION:=v$(PKG_VERSION)


PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-3.0-or-later
PKG_LICENSE_FILES:=LICENSE.txt

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

define Package/sentinel-nikola
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Sentinel
  TITLE:=Nikola
  URL:=https://gitlab.labs.nic.cz/turris/sentinel/nikola
  DEPENDS:=+python3-light +python3-setuptools +logrotate +syslog-ng +firewall +python3-msgpack +python3-zmq +sentinel-proxy
  VARIANT:=python3
endef

define Package/sentinel-nikola/description
  Collects firewall logs and sends it to sentinel.
endef

define Package/sentinel-nikola/conffiles
/etc/config/nikola
endef

define Py3Package/sentinel-nikola/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(CP) $(PKG_INSTALL_DIR)/usr/bin/* $(1)/usr/bin/

	$(INSTALL_DIR) $(1)/etc/config/
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/conf/uci/nikola $(1)/etc/config/nikola
	$(INSTALL_DIR) $(1)/etc/logrotate.d/
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/conf/logrotate.d/iptables $(1)/etc/logrotate.d/iptables
	$(INSTALL_DIR) $(1)/usr/share/nikola/bin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/conf/cron/nikola.sh $(1)/usr/share/nikola/bin/nikola.sh
	$(INSTALL_DIR) $(1)/etc/cron.d
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/conf/cron/nikola $(1)/etc/cron.d/nikola
	$(INSTALL_DIR) $(1)/etc/syslog-ng.d/
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/conf/syslog/syslog-ng.conf $(1)/etc/syslog-ng.d/nikola.conf
endef

define Package/sentinel-nikola/postinst
# check if we are on real system
if [ -z "$${IPKG_INSTROOT}" ]; then
	echo "Reloading syslog-ng"
	/etc/init.d/syslog-ng reload
fi
exit 0
endef

$(eval $(call Py3Package,sentinel-nikola))
$(eval $(call BuildPackage,sentinel-nikola))
$(eval $(call BuildPackage,sentinel-nikola-src))

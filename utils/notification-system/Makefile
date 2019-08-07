#
# Copyright (C) 2019 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=notification-system
PKG_VERSION:=0.3.0
PKG_RELEASE:=2

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/notification-system.git
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_VERSION:=c80c8451174814979d14381c926d78a80a329fbb

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-3.0-only
PKG_LICENSE_FILES:=COPYING

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

define Package/notification-system
  SECTION:=lang
  CATEGORY:=Languages
  SUBMENU:=Python
  TITLE:=Notification system
  URL:=https://gitlab.labs.nic.cz/turris/notification-system
  DEPENDS:= \
        +python3-light \
        +python3-yaml \
        +python3-jinja2 \
        +python3-logging \
        +python3-uci
  PROVIDES:=user-notify
  CONFLICTS:=user-notify
  VARIANT:=python3
endef

define Package/notification-system/description
  Notification system is tool that offers easy way to create and read notifications.
endef

define Py3Package/notification-system/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) ./files/bin/{notify-cli,create_notification,list_notifications,user-notify-display} $(1)/usr/bin/

	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/user_notify.config $(1)/etc/config/user_notify
endef

define Package/notification-system/conffiles
/etc/config/user_notify
endef

$(eval $(call Py3Package,notification-system))
$(eval $(call BuildPackage,notification-system))
$(eval $(call BuildPackage,notification-system-src))

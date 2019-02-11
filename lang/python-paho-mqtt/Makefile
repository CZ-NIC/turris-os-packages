include $(TOPDIR)/rules.mk

PKG_NAME:=python-paho-mqtt
PKG_VERSION:=1.2.3
PKG_RELEASE:=1
PKG_LICENSE:=Eclipse Public License v1.0 / Eclipse Distribution License v1.0

PKG_SOURCE:=paho-mqtt-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://pypi.python.org/packages/ce/27/28ac0859fb8d63754ec51659be265bf3b89d1568c5f6736d21026e11ea85/
PKG_MD5SUM:=4bd192ea24e7aa347f6d240101ef82f6

PKG_BUILD_DIR:=$(BUILD_DIR)/paho-mqtt-$(PKG_VERSION)
PKG_BUILD_DEPENDS:=python

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python-package.mk

define Package/python-paho-mqtt
  SUBMENU:=Python
  SECTION:=lang
  CATEGORY:=Languages
  MAINTAINER:=CZ.NIC <packaging@turris.cz>
  TITLE:=python-paho-mqtt
  URL:=http://eclipse.org/paho
  DEPENDS:=+python
endef

define Package/python-paho-mqtt/description
  MQTT version 3.1/3.1.1 client class
endef

define Build/Compile
  $(call Build/Compile/PyMod,,install --prefix="/usr" --root="$(PKG_INSTALL_DIR)")
endef

$(eval $(call PyPackage,python-paho-mqtt))
$(eval $(call BuildPackage,python-paho-mqtt))

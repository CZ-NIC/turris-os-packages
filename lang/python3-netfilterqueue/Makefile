#
# Copyright (C) 2015 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python3-netfilterqueue
PKG_VERSION:=0.8.1
PKG_RELEASE:=1

PKG_SOURCE:=NetfilterQueue-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://pypi.python.org/packages/source/n/netfilterqueue/
PKG_HASH:=beda851dfb8f3199f716e246c4cfd2c8492f7cdce32a03613c7eeab152e0a4a6

PKG_BUILD_DIR:=$(BUILD_DIR)/NetfilterQueue-$(PKG_VERSION)
PKG_BUILD_DEPENDS:=python3-setuptools cython3

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python3-package.mk)

define Package/$(PKG_NAME)
  TITLE:=python3-netfilterqueue
  SUBMENU:=Python
  SECTION:=lang
  CATEGORY:=Languages
  DEPENDS:=+python3-light +libnetfilter-queue
endef

define Package/$(PKG_NAME)/description
  NetfilterQueue provides access to packets matched by an iptables rule in Linux. Packets so matched can be accepted, dropped, altered, or given a mark.
endef

define Build/Compile
	$(call Build/Compile/Py3Mod,,install --root="$(PKG_INSTALL_DIR)" --prefix="/usr")
endef

$(eval $(call Py3Package,$(PKG_NAME)))
$(eval $(call BuildPackage,$(PKG_NAME)))

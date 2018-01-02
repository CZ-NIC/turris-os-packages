#
# Copyright (C) 2018 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=ooniprobe
PKG_VERSION:=2.2.0
PKG_RELEASE:=1
PKG_LICENSE:=MIT

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/TheTorProject/ooni-probe.git
PKG_SOURCE_VERSION:=v$(PKG_VERSION)
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python-package.mk)

PKG_BUILD_DEPENDS:=python-setuptools

define Package/$(PKG_NAME)
	SUBMENU:=Python
	SECTION:=lang
	CATEGORY:=Languages
	TITLE:=ooniprobe
	URL:=https://ooni.torproject.org/
	DEPENDS:=+python-light +pydumbnet +pypcap +twisted +python-cryptography \
		+python-openssl +python-pyasn1 python-pyasn1-modules +python-txsocksx \
		+scapy +python-pyopenssl +python-service-identity +python-ipaddress \
		+klein +txtorcon +libgeoip
	MAINTAINER:=CZ.NIC <packaging@turris.cz>
endef

define Package/$(PKG_NAME)/description
OONI, the Open Observatory of Network Interference aims  to collect high quality data using open methodologies, using (FL/OSS) to share observations and data about the various types, methods, and amounts of network tampering in the world.
endef

define Build/Compile
	$(call Build/Compile/PyMod,,install -v --prefix="/usr" --root=$(PKG_INSTALL_DIR))
endef

$(eval $(call PyPackage,ooniprobe))
$(eval $(call BuildPackage,ooniprobe))

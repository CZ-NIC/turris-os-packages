#
# Copyright (C) 2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=salt
PKG_VERSION:=2019.2.0
PKG_RELEASE:=0

PKG_LICENSE:=Apache 2.0
PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

PKG_SOURCE:=salt-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://files.pythonhosted.org/packages/41/d4/7f6d6bb139506741771ff9feb8429d5a5ed860de9ab5a358e771e8cc3b76/
PKG_HASH:=5695bb2b3fa288bcfc0e3b93d9449afd75220bd8f0deefb5e7fc03af381df6cd
PKG_BUILD_DIR:=$(BUILD_DIR)/salt-$(PKG_VERSION)
PKG_UNPACK=$(HOST_TAR) -C $(PKG_BUILD_DIR) --strip-components=1 -xzf $(DL_DIR)/$(PKG_SOURCE)

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

define Package/salt
	SECTION:=admin
	CATEGORY:=Administration
	TITLE:=Remote execution and configuration management system
	URL:=http://saltstack.org
	DEPENDS:=+python3 +python3-msgpack +python3-yaml +python3-requests +python3-pyopenssl +python3-crypto +python3-tornado
	VARIANT:=python3
endef

define Package/salt/description
 SaltStack makes software for complex systems management at scale. SaltStack is
 the company that created and maintains the Salt Open project and develops and
 sells SaltStack Enterprise software, services and support. Easy enough to get
 running in minutes, scalable enough to manage tens of thousands of servers, and
 fast enough to communicate with them in seconds.
endef


$(eval $(call Py3Package,salt))
$(eval $(call BuildPackage,salt))
$(eval $(call BuildPackage,salt-src))

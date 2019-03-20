#
# Copyright (C) 2019 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python-pyrsistent
PKG_VERSION:=0.14.11
PKG_RELEASE:=1

PKG_SOURCE:=pyrsistent-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://files.pythonhosted.org/packages/source/p/pyrsistent/
PKG_HASH:=3ca82748918eb65e2d89f222b702277099aca77e34843c5eb9d52451173970e2
PKG_BUILD_DIR:=$(BUILD_DIR)/pyrsistent-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

define Package/python3-pyrsistent
  SUBMENU:=Python
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=python3-pyrsistent
  URL:=https://github.com/tobgu/pyrsistent
  MAINTAINER:=CZ.NIC <packaging@turris.cz>
  DEPENDS:=+python3-light +python3-six
  VARIANT:=python3
endef

define Package/python3-pyrsistent/description
  Persistent/Immutable/Functional data structures for Python
endef

$(eval $(call Py3Package,python3-pyrsistent))
$(eval $(call BuildPackage,python3-pyrsistent))
$(eval $(call BuildPackage,python3-pyrsistent-src))

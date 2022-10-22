#
# Copyright (C) 2018-2020 CZ.NIC z.s.p.o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python-pbkdf2
PKG_VERSION:=1.3
PKG_RELEASE:=$(AUTORELEASE)

PYPI_NAME:=pbkdf2
PKG_HASH:=ac6397369f128212c43064a2b4878038dab78dab41875364554aaf2a684e6979

PKG_MAINTAINER:=
PKG_LICENSE:=MIT

include $(TOPDIR)/feeds/packages/lang/python/pypi.mk
include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

define Package/python3-pbkdf2
  SUBMENU:=Python
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=PKCS#5 v2.0 PBKDF2 Module
  URL:=https://www.dlitz.net/software/python-pbkdf2/
  DEPENDS:=+python3-light +python3-openssl
endef

define Package/python-pbkdf2/description
  PKCS#5 v2.0 PBKDF2 Module for Python
endef

$(eval $(call Py3Package,python3-pbkdf2))
$(eval $(call BuildPackage,python3-pbkdf2))
$(eval $(call BuildPackage,python3-pbkdf2-src))

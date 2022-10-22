#
# Copyright (C) 2018-2020 CZ.NIC z.s.p.o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python-prctl
PKG_VERSION:=1.8.1
PKG_RELEASE:=$(AUTORELEASE)

PYPI_NAME:=python-prctl
PKG_HASH:=b4ca9a25a7d4f1ace4fffd1f3a2e64ef5208fe05f929f3edd5e27081ca7e67ce

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-3.0-or-later
PKG_LICENSE_FILES:=COPYING

include $(TOPDIR)/feeds/packages/lang/python/pypi.mk
include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

define Package/python3-prctl
  SUBMENU:=Python
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=Python(ic) interface to the linux prctl syscall
  URL:=https://github.com/seveas/python-prctl
  DEPENDS:= \
  +python3-light \
  +libcap
endef

define Package/python3-prctl/description
  Multi-producer-multi-consumer signal dispatching mechanism
endef

PYTHON3_PKG_SETUP_ARGS:=

$(eval $(call Py3Package,python3-prctl))
$(eval $(call BuildPackage,python3-prctl))
$(eval $(call BuildPackage,python3-prctl-src))

#
# Copyright (C) 2018-2020 CZ.NIC z.s.p.o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python-prctl
PKG_VERSION:=1.7
PKG_RELEASE:=2

PYPI_NAME:=python-prctl
PKG_HASH:=57ebd556616d6ffe1f794f514680e84a03737cb070de37722198d7ad6c8f4fda

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
  VARIANT:=python3
endef

define Package/python3-prctl/description
  Multi-producer-multi-consumer signal dispatching mechanism
endef

PYTHON3_PKG_SETUP_ARGS:=

$(eval $(call Py3Package,python3-prctl))
$(eval $(call BuildPackage,python3-prctl))
$(eval $(call BuildPackage,python3-prctl-src))

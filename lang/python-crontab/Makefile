#
# Copyright (C) 2021 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python-crontab
PKG_VERSION:=0.23.0
PKG_RELEASE:=$(AUTORELEASE)

PKG_LICENSE:=LGPL-3.0-or-later
PKG_LICENSE_FILES:=LICENSE3

PYPI_NAME:=crontab
PKG_HASH:=ca79dede9c2f572bb32f38703e8fddcf3427e86edc838f2ffe7ae4b9ee2b0733

include $(TOPDIR)/feeds/packages/lang/python/pypi.mk
include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

PYTHON3_PKG_SETUP_ARGS :=

define Package/python3-crontab
  SECTION:=lang-python
  CATEGORY:=Languages
  SUBMENU:=Python
  TITLE:=Parse and use crontab schedules in Python
  URL:=https://github.com/josiahcarlson/parse-crontab
  DEPENDS:=+python3-light
endef

define Package/python3-crontab/description
 This package intends to offer a method of parsing crontab schedule entries and
 determining when an item should next be run. More specifically, it calculates a
 delay in seconds from when the .next() method is called to when the item should
 next be executed.
endef

$(eval $(call Py3Package,python3-crontab))
$(eval $(call BuildPackage,python3-crontab))
$(eval $(call BuildPackage,python3-crontab-src))

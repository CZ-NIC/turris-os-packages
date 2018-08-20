#
# Copyright (C) 2018 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=python-prctl
PKG_VERSION:=1.6.1
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://pypi.python.org/packages/2c/a6/a866caf122908583f5f5e27217ca7f956c616e48e35cdb2a4a60ab4c7ad8/
PKG_MD5SUM:=5f36d6a1e832ca29f9fc458b5ace1627

PKG_BUILD_DIR:=$(BUILD_DIR)/$(BUILD_VARIANT)-$(PKG_NAME)-$(PKG_VERSION)
PKG_BUILD_DEPENDS:=python3 python libcap

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python-package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

PKG_UNPACK:=$(HOST_TAR) -C $(PKG_BUILD_DIR) --strip-components=1 -xzf $(DL_DIR)/$(PKG_SOURCE)

define Package/python-prctl/Default
	SUBMENU:=Python
	SECTION:=lang
	CATEGORY:=Languages
	URL:=https://pythonhosted.org/python-prctl/
	MAINTAINER:=CZ.NIC <packaging@turris.cz>
	DEPENDS:=+libcap
endef

define Package/python-prctl
	$(call Package/python-prctl/Default)
	TITLE:=python-prctl
	DEPENDS+=+PACKAGE_python-prctl:python-light
	VARIANT:=python
endef

define Package/python3-prctl
	$(call Package/python-prctl/Default)
	TITLE:=python3-prctl
	DEPENDS+=+PACKAGE_python3-prctl:python3-light
	VARIANT:=python3
endef

define Package/python-prctl/description
	Python(ic) interface to the linux prctl syscall
endef

define Package/python3-prctl/description
  $(call Package/python-prctl/description)
  .
  (Variant for Python3)
endef

define PyBuild/Compile
	$(call Build/Compile/PyMod,,install --prefix="/usr" --root="$(PKG_INSTALL_DIR)")
endef

define Py3Build/Compile
	$(call Build/Compile/Py3Mod,,install --prefix="/usr" --root="$(PKG_INSTALL_DIR)")
endef


$(eval $(call PyPackage,python-prctl))
$(eval $(call BuildPackage,python-prctl))
$(eval $(call BuildPackage,python-prctl-src))

$(eval $(call Py3Package,python3-prctl))
$(eval $(call BuildPackage,python3-prctl))
$(eval $(call BuildPackage,python3-prctl-src))

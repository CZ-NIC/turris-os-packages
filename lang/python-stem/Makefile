#
# Copyright (C) 2017 CZ.NIC
#

include $(TOPDIR)/rules.mk

PKG_NAME:=stem
PKG_VERSION:=1.6.0
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://pypi.python.org/packages/11/d5/e51983f81b38408ae2f0e166481ad867962f6fa07610fe71119534e12d41
PKG_MD5SUM:=fbf900e5c53441f7297b55154e3f34ea
PKG_LICENSE:=LGPLv3

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python-package.mk)

define Package/python-stem
	SECTION:=lang
	CATEGORY:=Languages
	SUBMENU:=Python
	TITLE:=python-stem
	URL:=https://stem.torproject.org/
	DEPENDS:=+python-light +python-ctypes +python-crypto +python-distutils
endef

define Package/python-stem/description
Stem is a Python controller library that allows applications to
interact with Tor (https://www.torproject.org/).
endef

define Build/Compile
	$(call Build/Compile/PyMod,,install --prefix="/usr" --root="$(PKG_INSTALL_DIR)")
endef

$(eval $(call PyPackage,python-stem))
$(eval $(call BuildPackage,python-stem))

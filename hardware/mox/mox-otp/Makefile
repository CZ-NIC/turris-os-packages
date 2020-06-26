#
## Copyright (C) 2019 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=mox-otp
PKG_VERSION:=0.2.1
PKG_RELEASE:=2

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/mox-otp.git
PKG_SOURCE_VERSION:=v$(PKG_VERSION)

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-3.0-or-later
PKG_LICENSE_FILES:=LICENSE.md

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

define Package/mox-otp
  TITLE:=MOX OTP CLI
  URL:=https://gitlab.nic.cz/turris/mox-otp
  PROVIDES:=turris-otp
  DEPENDS:=+python3-light
  DEPENDS+=@TARGET_mvebu_cortexa53_DEVICE_cznic-mox
  VARIANT:=python3
endef

define Package/mox-otp/description
  Command line tool to query MOX CPU read-only OTP device
endef

$(eval $(call Py3Package,mox-otp))
$(eval $(call BuildPackage,mox-otp))
$(eval $(call BuildPackage,mox-otp-src))

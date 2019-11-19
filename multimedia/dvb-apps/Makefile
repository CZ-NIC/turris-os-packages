#
# Copyright (C) 2006-2011 OpenWrt.org
# Copyright (C) 2017 Tomasz Maciej Nowak <tomek_n@o2.pl>
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk

PKG_NAME:=dvb-apps
PKG_VERSION:=3d43b280298c
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=https://linuxtv.org/hg/dvb-apps/archive/
PKG_HASH:=70c1d293ea3ddbcb970e01c8a51487ee97a4dcf33a73c0236c7d57757c7f6fb0

PKG_MAINTAINER:=Tomasz Maciej Nowak <tomek_n@o2.pl>
PKG_LICENSE:=GPL-2.0 LGPL-2.1
PKG_LICENSE_FILES:=COPYING COPYING.LGPL

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/dvb-apps/Default
  TITLE:=Linux DVB API applications and utilities
  URL:=https://linuxtv.org
endef

define Package/dvb-apps/description/Default
  Linux DVB API applications and utilities.
endef

define Build/InstallDev
	$(CP) $(PKG_INSTALL_DIR)/* $(1)/
endef


# 1: short name
# 2: description
# 3: dependencies on other Linux DVB API libraries (short name)
# 4: dependencies on other Linux DVB API applications (short name)
# 5: dependencies on other packages
define DvbBuildApp

  DVBA_DEPENDS += +dvb-app-$(1)

  define Package/dvb-app-$(1)
    $(call Package/dvb-apps/Default)
    SECTION := multimedia
    CATEGORY := Multimedia
    TITLE := $(1) application
    DEPENDS += $$(foreach p,$(3),+lib$$(p)) $$(foreach p,$(4),+dvb-app-$$(p)) $(5)
  endef

  define Package/dvb-app-$(1)/description
   $(call Package/dvb-apps/description/Default)
   .
   This package contains the Linux DVB $(1) application.
  endef

  define Package/dvb-app-$(1)/install
	$(INSTALL_DIR) $$(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/$(1) $$(1)/usr/bin
  endef

  $$(eval $$(call BuildPackage,dvb-app-$(1)))
endef

$(eval $(call DvbBuildApp,atsc_epg,atsc_epg,dvbapi ucsi,,))
$(eval $(call DvbBuildApp,av7110_loadkeys,av7110_loadkeys,,,))
$(eval $(call DvbBuildApp,azap,szap,,,))
$(eval $(call DvbBuildApp,czap,szap,,,))
$(eval $(call DvbBuildApp,dib3000-watch,dib3000-watch,,,))
$(eval $(call DvbBuildApp,dst_test,dst-utils,,,))
$(eval $(call DvbBuildApp,dvbdate,dvbdate,dvbapi ucsi,,))
$(eval $(call DvbBuildApp,dvbnet,dvbnet,dvbapi,,))
$(eval $(call DvbBuildApp,dvbscan,dvbscan,dvbcfg ucsi dvbsec dvbapi,,+libpthread))
$(eval $(call DvbBuildApp,dvbtraffic,dvbtraffic,dvbapi,,))
$(eval $(call DvbBuildApp,femon,femon,dvbapi,,))
$(eval $(call DvbBuildApp,gnutv,gnutv,dvbcfg dvben50221 ucsi dvbsec dvbapi,,+libpthread))
$(eval $(call DvbBuildApp,gotox,gotox,dvbapi dvbsec,,))
$(eval $(call DvbBuildApp,scan,scan,,,$(ICONV_DEPENDS)))
$(eval $(call DvbBuildApp,szap,szap,,,))
$(eval $(call DvbBuildApp,tzap,szap,,,))
$(eval $(call DvbBuildApp,zap,zap,dvbcfg dvben50221 dvbsec dvbapi ucsi,,+libpthread))


# 1: short name
# 2: description
# 3: dependencies on other Linux DVB API libraries (short name)
# 4: dependencies on other packages
define DvbBuildLibrary

  DVBA_DEPENDS += +lib$(1)

  define Package/lib$(1)
    $(call Package/dvb-apps/Default)
    SECTION := libs
    CATEGORY := Libraries
    TITLE := $(2) library
    DEPENDS += $$(foreach p,$(3),+lib$$(p)) $(4)
  endef

  define Package/lib$(1)/description
   $(call Package/dvb-apps/description/Default)
   .
   This package contains the Linux DVB $(1\2) library.
  endef

  define Package/lib$(1)/install
	$(INSTALL_DIR) $$(1)/usr/lib
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/lib/lib$(1).so* \
		$$(1)/usr/lib
  endef

  $$(eval $$(call BuildPackage,lib$(1)))
endef

$(eval $(call DvbBuildLibrary,dvbapi,dvbapi,,))
$(eval $(call DvbBuildLibrary,dvbcfg,dvbcfg,,))
$(eval $(call DvbBuildLibrary,dvben50221,dvben50221,ucsi,))
$(eval $(call DvbBuildLibrary,dvbsec,dvbsec,,))
$(eval $(call DvbBuildLibrary,esg,esg,,))
$(eval $(call DvbBuildLibrary,ucsi,ucsi,,))


DVBA_DEPENDS += +dvb-keymaps-av7110

define Package/dvb-keymaps-av7110
  $(call Package/dvb-apps/Default)
  SECTION := multimedia
  CATEGORY := Multimedia
  TITLE := av7110 keymaps
endef

define Package/dvb-keymaps-av7110/description
  $(call Package/dvb-apps/description/Default)
  .
  This package contains keymaps for the av7110_loadkeys application.
endef

define Package/dvb-keymaps-av7110/install
	$(INSTALL_DIR) $(1)/usr/share/dvb/av7110_loadkeys
	$(CP) $(PKG_INSTALL_DIR)/usr/share/dvb/av7110_loadkeys/* \
		$(1)/usr/share/dvb/av7110_loadkeys
endef

$(eval $(call BuildPackage,dvb-keymaps-av7110))

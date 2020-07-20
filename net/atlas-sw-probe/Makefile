#
# Copyright (C) 2019-2020 CZ.NIC z.s.p.o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk

PKG_NAME:=atlas-sw-probe
PKG_VERSION:=5020
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/ripe-atlas-software-probe
PKG_SOURCE_VERSION:=ce9daafbdcce731f2352877365e6b6b3a0a89a09

PKG_SOURCE:=ripe-atlas-software-probe-$(PKG_VERSION).tar.gz

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-3.0-or-later
PKG_LICENSE_FILES:=LICENSE

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/atlas-sw-probe
  SECTION:=net
  CATEGORY:=Network
  TITLE:=RIPE Atlas software probe
  URL:=https://atlas.ripe.net/about/probes/
  DEPENDS:=+atlas-probe
endef

define Package/atlas-sw-probe/description
  RIPE Atlas SW probe is software variant of RIPE Atlas Probe.
  It contains utilities which helps actively measure
  Internet connectivity through ping, traceroute, DNS, SSL/TLS, NTP, and HTTP.
  Data are then collected, aggregated and published by the RIPE NCC.
endef

define Build/Compile
	true
endef

define Build/Install
	true
endef

define Package/atlas-sw-probe/postinst
	true
endef

define Package/atlas-sw-probe/conffiles
/etc/config/atlas
/usr/libexec/atlas-probe-scripts/state/config.txt
endef

TMP_BASE_DIR:=/tmp/ripe_atlas_probe
SCRIPTS_DIR:=/usr/libexec/atlas-probe-scripts

define Package/atlas-sw-probe/install
	$(INSTALL_DIR) $(1)/$(SCRIPTS_DIR)
	$(INSTALL_DIR) $(1)/$(SCRIPTS_DIR)/{etc,state,bin/arch,bin/bin}

	# Copy config
	$(CP) $(PKG_BUILD_DIR)/atlas-config/etc/* $(1)/$(SCRIPTS_DIR)/etc/

	# Copy firmware version
	$(CP) $(PKG_BUILD_DIR)/atlas-config/state/FIRMWARE_APPS_VERSION $(1)/$(SCRIPTS_DIR)/state/
	# Set probe mode
	echo "prod" > $(1)/$(SCRIPTS_DIR)/state/mode

	# Copy scripts
	$(CP) $(PKG_BUILD_DIR)/bin/{ATLAS,common-pre.sh,common.sh,reginit.sh,resolvconf} $(1)/$(SCRIPTS_DIR)/bin/
	$(CP) $(PKG_BUILD_DIR)/bin/arch/{linux,turris-sw-probe} $(1)/$(SCRIPTS_DIR)/bin/arch/

	# Create config info
	echo "DEVICE_NAME=turris-sw-probe" > $(1)/$(SCRIPTS_DIR)/bin/config.sh
	echo "ATLAS_BASE=$(SCRIPTS_DIR)" >> $(1)/$(SCRIPTS_DIR)/bin/config.sh
	echo "ATLAS_STATIC=$(SCRIPTS_DIR)" >> $(1)/$(SCRIPTS_DIR)/bin/config.sh
	echo "SUB_ARCH=turris-$(ARCH)-$(PKG_VERSION)-$(PKG_RELEASE)" >> $(1)/$(SCRIPTS_DIR)/bin/bin/config.sh

	# Enable sending interface traffic statistics as Atlas measurement results
	echo "RXTXRPT=yes" > $(1)/$(SCRIPTS_DIR)/state/config.txt

	# Fix permision
	chmod 755 $(1)/$(SCRIPTS_DIR)/bin

	# Create softlinks for writable dirs
	$(LN) $(TMP_BASE_DIR)/crons $(1)/$(SCRIPTS_DIR)/crons
	$(LN) $(TMP_BASE_DIR)/data $(1)/$(SCRIPTS_DIR)/data
	$(LN) $(TMP_BASE_DIR)/run $(1)/$(SCRIPTS_DIR)/run
	$(LN) $(TMP_BASE_DIR)/status $(1)/$(SCRIPTS_DIR)/status

	# Copy init and config
	$(INSTALL_DIR) $(1)/etc/init.d/
	$(INSTALL_BIN) ./files/atlas.init $(1)/etc/init.d/atlas

	$(INSTALL_DIR) $(1)/etc/config/
	$(INSTALL_CONF) ./files/atlas.conf $(1)/etc/config/atlas
endef

$(eval $(call BuildPackage,atlas-sw-probe))

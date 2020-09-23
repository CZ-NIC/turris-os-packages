include $(TOPDIR)/rules.mk

PKG_NAME:=optin-migration
PKG_VERSION:=1.0.0
PKG_RELEASE:=1

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

include $(INCLUDE_DIR)/package.mk

define Package/optin-migration
  TITLE:=Notification that users can do opt-in migration to newer version of TOS
  DEPENDS:=+user-notify
endef


define Package/optin-migration/postinst
#!/bin/sh
[ -n "$$IPKG_INSTROOT" ] || {
	create_notification -s news \
		"Migrace na novější verzi Turris OS je k dispozici. Prosím přečtěte si následující dokumentaci pro volitelné spuštění aktualizace: https://docs.turris.cz/geek/tos3_migration/" \
		"Migration on to the newer major Turris OS version is available. Please read following documentation to optionally trigger it: https://docs.turris.cz/geek/tos3_migration/"
}
endef

define Build/Compile
	true
endef

define Package/optin-migration/install
	true
endef

$(eval $(call BuildPackage,optin-migration))

include $(TOPDIR)/rules.mk

PKG_NAME:=taskserver
PKG_VERSION:=1.1.0
PKG_RELEASE:=1

PKG_LICENSE:=MIT

PKG_SOURCE:=taskd-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://www.taskwarrior.org/download/
PKG_HASH:=7b8488e687971ae56729ff4e2e5209ff8806cf8cd57718bfd7e521be130621b4
PKG_MAINTAINER:=Jan Pavlinec <jan.pavlinec@nic.cz>

PKG_BUILD_DIR:=$(BUILD_DIR)/taskd-$(PKG_VERSION)

PKG_BUILD_PARALLEL:=1
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/taskserver
  TITLE:=taskserver
  SECTION:=utils
  CATEGORY:=Utilities
  DEPENDS:=+libstdcpp +libuuid +libgnutls
  URL:=https://taskwarrior.org/
endef

#TARGET_LDFLAGS += -ldl

define Package/taskserver/description
 taskserver is a command-line todo list manager
endef

define Package/taskserver/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/{taskd,taskdctl} $(1)/usr/bin/
endef

$(eval $(call BuildPackage,taskserver))

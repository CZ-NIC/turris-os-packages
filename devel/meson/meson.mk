ifneq ($(__meson_mk_inc),1)
__meson_mk_inc=1

include $(TOPDIR)/feeds/turrispackages/ninja/ninja.mk

CROSS_CONF_FILE=$(STAGING_DIR)/cross_conf.txt
HOST_PYTHON3_BIN ?= $(TOPDIR)/staging_dir/hostpkg/bin/python3
HOST_MESON_BIN=$(STAGING_DIR_HOST)/meson/meson.py
MESON_BUILD_DIR ?= builddir
PKG_BUILD_DEPENDS += meson/host python3/host

define Build/Meson/Configure
	cd $(PKG_BUILD_DIR) && [ ! -d $(MESON_BUILD_DIR) ] && mkdir $(MESON_BUILD_DIR)
	cd $(PKG_BUILD_DIR) && PKG_CONFIG_PATH=$(PKG_CONFIG_PATH) $(HOST_PYTHON3_BIN) $(HOST_MESON_BIN) $(MESON_BUILD_DIR) --cross-file $(CROSS_CONF_FILE) $(MESON_ARGS)
endef

define Build/Meson/Compile
	$(call Build/Ninja/Compile,$(MESON_BUILD_DIR))
endef

define Build/Meson/Install
	$(call Build/Ninja/Install,$(MESON_BUILD_DIR))
endef

define Build/Configure
	$(call Build/Meson/Configure)
endef

define Build/Compile
	$(call Build/Meson/Compile)
endef

define Build/Install
	$(call Build/Meson/Install)
endef

endif

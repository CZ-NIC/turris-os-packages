include $(TOPDIR)/rules.mk

PKG_NAME:=python-certifi
PKG_VERSION:=2019.3.9
PKG_RELEASE:=1

PKG_SOURCE:=certifi-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://files.pythonhosted.org/packages/source/c/certifi
PKG_HASH:=b26104d6835d1f5e49452a26eb2ff87fe7090b89dfcaee5ea2212697e1e1d7ae

PKG_BUILD_DIR:=$(BUILD_DIR)/certifi-p2-$(PKG_VERSION)
PKG_UNPACK:=tar -C $(PKG_BUILD_DIR) --strip-components=1 -xzf $(DL_DIR)/$(PKG_SOURCE)

PKG_BUILD_DEPENDS:=python-setuptools

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python-package.mk)

define Package/python-certifi
  SUBMENU:=Python
  SECTION:=lang
  CATEGORY:=Languages
  TITLE:=Python package for providing Mozilla's CA Bundle
  URL:=https://certifi.io/
  DEPENDS:=+python3
endef

define Package/python-certifi/description
  Certifi is a carefully curated collection of Root Certificates for validating the
  trustworthiness of SSL certificates while verifying the identity of TLS hosts.
endef

define Build/Compile
	$(call Build/Compile/PyMod,, \
		install --root="$(PKG_INSTALL_DIR)" --prefix="/usr"  \
		--single-version-externally-managed \
	)
endef

$(eval $(call PyPackage,python-certifi))
$(eval $(call BuildPackage,python-certifi))

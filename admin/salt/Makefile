include $(TOPDIR)/rules.mk

PKG_NAME:=salt
PKG_VERSION:=2019.2.0
PKG_RELEASE:=1

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=Apache-2.0
PKG_LICENSE_FILES:=LICENSE

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://files.pythonhosted.org/packages/source/s/salt/
PKG_HASH:=5695bb2b3fa288bcfc0e3b93d9449afd75220bd8f0deefb5e7fc03af381df6cd

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

PYTHON3_PKG_SETUP_ARGS:=

define Package/salt
  SECTION:=admin
  CATEGORY:=Administration
  TITLE:=Remote execution and configuration management system
  URL:=https://www.saltstack.com/
  DEPENDS:= \
  +python3-light \
  +python3-jinja2 \
  +python3-msgpack \
  +python3-yaml \
  +python3-markupsafe \
  +python3-requests \
  +python3-tornado \
  +python3-pyzmq
  VARIANT:=python3
endef

define Package/salt/description
 SaltStack makes software for complex systems management at scale. SaltStack is
 the company that created and maintains the Salt Open project and develops and
 sells SaltStack Enterprise software, services and support. Easy enough to get
 running in minutes, scalable enough to manage tens of thousands of servers, and
 fast enough to communicate with them in seconds.
endef

$(eval $(call Py3Package,$(PKG_NAME)))
$(eval $(call BuildPackage,$(PKG_NAME)))
$(eval $(call BuildPackage,$(PKG_NAME)-src))

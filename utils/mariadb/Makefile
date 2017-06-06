#
# Copyright (C) 2006-2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/uclibc++.mk

PKG_NAME:=mariadb
PKG_VERSION:=10.2.6
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=\
  http://mirror.nodesdirect.com/mariadb//mariadb-$(PKG_VERSION)/source/

PKG_MD5SUM:=3d454cdadbd3208e1c9c23e5338a62b0
PKG_MAINTAINER:=Jo-Philipp Wich <jo@mein.io>
PKG_LICENSE:=GPL-2.0

PKG_BUILD_DEPENDS:=libncurses libreadline mariadb/host
PKG_BUILD_PARALLEL:=1

HOST_BUILD_DEPENDS:=ncurses/host openssl/host

PKG_FIXUP:=libtool

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/host-build.mk
include $(INCLUDE_DIR)/cmake.mk

CMAKE_OPTIONS:= -DSTACK_DIRECTION=-1 \
                -DHAVE_IB_GCC_ATOMIC_BUILTINS=1 \
                -DIMPORT_EXECUTABLES=$(STAGING_DIR_HOST)/mariadb-import_executables \
                -DPLUGIN_HANDLERSOCKET=NO \
                -DPLUGIN_XTRADB=DYNAMIC \
                -DPLUGIN_TOKUDB=DYNAMIC \
                -DWITH_UNIT_TESTS=OFF \
                -DWITH_WSREP=OFF \
                -DWITH_INNODB_LZO=OFF \
                -DWITH_INNODB_BZIP2=OFF \
                -DINSTALL_MYSQLSHAREDIR=share/mariadb \
                -DINSTALL_LAYOUT=RPM \
                -DINSTALL_PLUGINDIR=lib/mariadb/plugin \
                -DINSTALL_MYSQLDATADIR=/srv/mysql \
                -DINSTALL_UNIX_ADDRDIR=/var/run/mysql.sock

define Package/libmariadbclient
  SECTION:=libs
  CATEGORY:=Libraries
  DEPENDS:=$(CXX_DEPENDS) +zlib +libpthread +libopenssl
  TITLE:=MariaDB client library
  URL:=http://dev.mysql.com/
endef

define Package/mariadb-server
  SECTION:=utils
  CATEGORY:=Utilities
  DEPENDS:=+libmariadbclient +libpthread +libncurses +libreadline +zlib +libpcre +libstdcpp
  TITLE:=MariaDB Server
  URL:=http://dev.mysql.com/
  SUBMENU:=database
  USERID:=mysql=6446:mysql=6446
endef

define Host/Configure
	cd $(HOST_BUILD_DIR); \
	mkdir build; \
	cd build; \
	cmake \
                       -DCMAKE_BUILD_TYPE=Release \
                        -DCMAKE_C_FLAGS_RELEASE="-DNDEBUG" \
                        -DCMAKE_CXX_FLAGS_RELEASE="-DNDEBUG" \
                        -DCMAKE_EXE_LINKER_FLAGS:STRING="$(HOST_LDFLAGS)" \
                        -DCMAKE_MODULE_LINKER_FLAGS:STRING="$(HOST_LDFLAGS)" \
                        -DCMAKE_SHARED_LINKER_FLAGS:STRING="$(HOST_LDFLAGS)" \
                        -DCMAKE_FIND_ROOT_PATH="$(CMAKE_HOST_FIND_ROOT_PATH)" \
                        -DCMAKE_FIND_ROOT_PATH_MODE_PROGRAM=BOTH \
                        -DCMAKE_FIND_ROOT_PATH_MODE_LIBRARY=ONLY \
                        -DCMAKE_FIND_ROOT_PATH_MODE_INCLUDE=ONLY \
                        -DCMAKE_STRIP=: \
                        -DCMAKE_INSTALL_PREFIX=$(STAGING_DIR_HOST) \
                        -DCMAKE_PREFIX_PATH=$(STAGING_DIR_HOST) \
                        -DCMAKE_SKIP_RPATH=TRUE  \
                        $(CMAKE_HOST_OPTIONS) \
	..
endef

define Host/Compile
	cd $(HOST_BUILD_DIR)/build; make import_executables
endef

define Host/Install
	mkdir -p $(STAGING_DIR_HOST); \
	cd $(HOST_BUILD_DIR); $(CP) build $(STAGING_DIR_HOST)/mariadb-import_executables
endef

define Build/InstallDev
	$(INSTALL_DIR) $(2)/bin $(1)/usr/bin $(1)/usr/include $(1)/usr/lib
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/mysql_config $(1)/usr/bin/
	ln -sf $(STAGING_DIR)/usr/bin/mysql_config $(2)/bin/
	$(CP) $(PKG_INSTALL_DIR)/usr/include/mysql $(1)/usr/include/
	# NOTE: needed for MySQL-Python
	$(CP) $(PKG_BUILD_DIR)/include/mysqld_error.h $(1)/usr/include/mysql/
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/mariadb $(1)/usr/lib/
	rm -f $(1)/usr/lib/*.la
endef

define Package/libmariadbclient/install
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/libmariadb*.so.* $(1)/usr/lib/
endef

define Package/mariadb-server/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/* $(1)/usr/bin/
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/mysqld $(1)/usr/sbin/
	$(RM) $(1)/usr/bin/resolveip $(1)/usr/bin/mysqltest
	$(INSTALL_DIR) $(1)/usr/lib/mariadb/plugin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/lib/mariadb/plugin/* $(1)/usr/lib/mariadb/plugin
	$(INSTALL_DIR) $(1)/etc/init.d/
	$(INSTALL_BIN) files/mysqld.init $(1)/etc/init.d/mysqld
	$(INSTALL_CONF) $(PKG_INSTALL_DIR)/usr/share/mysql/my-small.cnf $(1)/etc/my.cnf
	$(INSTALL_DIR) $(1)/usr/share/mariadb
	$(INSTALL_DIR) $(1)/usr/share/mariadb/english
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/share/mariadb/english/errmsg.sys $(1)/usr/share/mariadb/english
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/share/mariadb/*.sql $(1)/usr/share/mariadb/
endef

define Package/mariadb-server/conffiles
/etc/my.cnf
endef

$(eval $(call BuildPackage,mariadb-server))
$(eval $(call BuildPackage,libmariadbclient))
$(eval $(call HostBuild))

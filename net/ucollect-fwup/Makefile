#
## Copyright (C) 2015 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#

include ../ucollect-prog/Makefile.common

$(eval $(call UCOLLECT_PLUGIN,fwup,12,diffstore.1))

define Package/ucollect-fwup
	SECTION:=net
	CATEGORY:=Network
	TITLE:=The fwup pluglib for ucollect
	DEPENDS:=+ucollect-lib +ipset +turris-firewall-rules
endef

$(eval $(call BuildPackage,ucollect-fwup))

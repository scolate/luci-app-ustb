include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-ustb
PKG_VERSION=2.0
PKG_RELEASE:=1

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/luci-app-ustb
		SECTION:=luci
		CATEGORY:=LuCI
		SUBMENU:=3. Applications
		TITLE:=USTB Net Tools for LuCI
		PKGARCH:=all
endef

define Package/luci-app-ustb/description
This package contains LuCI configuration pages for USTB.
endef

define Build/Prepare
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/luci-app-ustb/install
$(INSTALL_DIR) $(1)/etc/config
		$(INSTALL_DIR) $(1)/usr/share/USTB
		$(INSTALL_DIR) $(1)/etc/init.d
		$(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi
		$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller
		$(INSTALL_DIR) $(1)/etc/uci-defaults
		$(INSTALL_DIR) $(1)/usr/lib/lua/luci/view/ustb

		$(INSTALL_CONF) ./root/etc/uci-defaults/* $(1)/etc/uci-defaults
		$(INSTALL_CONF) ./root/etc/config/ustb $(1)/etc/config/ustb
		$(INSTALL_BIN) ./root/etc/init.d/ustb $(1)/etc/init.d/ustb
		$(INSTALL_BIN) ./root/usr/share/USTB/link.sh $(1)/usr/share/USTB/link.sh
		$(INSTALL_BIN) ./root/usr/share/USTB/ipv6.sh $(1)/usr/share/USTB/ipv6.sh
		$(INSTALL_BIN) ./root/usr/share/USTB/fee.sh $(1)/usr/share/USTB/fee.sh
		$(INSTALL_DATA) ./luasrc/model/cbi/advance.lua $(1)/usr/lib/lua/luci/model/cbi/advance.lua
		$(INSTALL_DATA) ./luasrc/model/cbi/ustb.lua $(1)/usr/lib/lua/luci/model/cbi/ustb.lua
		$(INSTALL_DATA) ./luasrc/model/cbi/ustblog.lua $(1)/usr/lib/lua/luci/model/cbi/ustblog.lua
		$(INSTALL_DATA) ./luasrc/controller/ustb.lua $(1)/usr/lib/lua/luci/controller/ustb.lua
		$(INSTALL_DATA) ./luasrc/view/ustb/ustb.htm $(1)/usr/lib/lua/luci/view/ustb/ustb.htm
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
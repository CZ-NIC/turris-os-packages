module("luci.controller.radius", package.seeall)

function index()
        if not nixio.fs.access("/etc/config/radius") then
                return
        end

        entry({"admin", "services", "radius"},
                alias("admin", "services", "radius", "users"),
                _("Radius"), 70)

        entry({"admin", "services", "radius", "users"},
                cbi("radius/users"), _("Users"), 10).leaf = true

        entry({"admin", "services", "radius", "clients"},
                cbi("radius/clients"), _("Clients"), 20).leaf = true
end

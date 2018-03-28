local m, s, o

m = Map("radius", translate("Radius - Users"), translate("User Accounts."))

s = m:section(TypedSection, "user", nil)
s.template = "cbi/tblsection"
s.anonymous = true
s.addremove = true

o = s:option(Value, "username", translate("Username"))
o.datatype = "uciname"
o.rmempty = false

o = s:option(Value, "password", translate("Password"))
o.password = true
o.rmempty = false

return m

-- The 3.x version uses updater 61.1.5
if version_match(self_version, "<62") then

	local automatic = os.execute("tos3to4-automatic")
	if automatic == 0 then
		Install("tos3to4", { priority = 40 })
		Package("tos3to4", { replan = "finished" })
	end

end

if getResourceName(getThisResource()):lower == "openframe" then
	local script = {}

	function push(str)
		table.insert(script, str)
	end

	function load()
		return table.concat(script, "\n\n")
	end
else
	loadstring(exports.openframe:load())()
end
if getResourceName(getThisResource()) == "openframe" then
	local script = {}

	function push(str)
		table.insert(script, str)
	end

  function getScripts()
    return script
  end

	function load()
    return 'for i,v in ipairs(exports.openframe:getScripts()) do loadstring(v)() end'
	end
else
	loadstring(exports.openframe:load())()
end
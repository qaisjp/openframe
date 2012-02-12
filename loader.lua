local script = {}

function push(str)
	table.insert(script, str)
end

function load()
	return script
end
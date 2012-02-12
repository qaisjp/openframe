push([[

function error_fallback(t, k)
	error(k .. " key not found")
end

Error = Class:Create()
Error.__index = error_fallback

]])
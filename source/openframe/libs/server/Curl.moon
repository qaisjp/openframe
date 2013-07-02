if not getModuleInfo "mtasa-curl"
	return;

class Curl
	pCurl = nil

	new: (url = "") ->
		@pCurl = curl_init(url)

	setopt_table: (options) ->
		for option, value in pairs(options)
			curl_setopt(@pCurl, option, value)

	setopt: (option, value) ->
		curl_setopt(@pCurl, option, value)

	
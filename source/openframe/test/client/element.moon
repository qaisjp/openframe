
export testElement

outputDebugString "Hello element"

testElement = ->
	superman = Element "superhero", "superman"
	id = superman\id()

	outputDebugString tostring(id)
	outputChatBox tostring(id)
	outputConsole tostring(id)

	outputConsole "Hello element"

addCommandHandler "testelem", ->
	outputChatBox "Hello world"

addEventHandler "onClientResourceStart", getResourceRootElement(getThisResource()), testElement

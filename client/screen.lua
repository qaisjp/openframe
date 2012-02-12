push([[
Screen = Class:Create()
Screen.x, Screen.y = guiGetScreenSize()

function Screen:Image(x, y, w, h, image, r, rx, ry, color, postgui)
	return dxDrawImage(x, y, w, h, image, r, rx, ry, color, postgui);
end

function Screen:Text(text, left, top, right, bottom, color, scale, font, alignX, alignY, clip, wordBreak, postGUI)
	return dxDrawText(text, left, top, right, bottom, color, scale, font, alignX, alignY, clip, wordBreak, postGUI);
end

function Screen:Rectangle(x, y, w, h, color, postgui)
	return dxDrawRectangle(x, y, w, h, color, postgui);
end
]])
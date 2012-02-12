push([[
-----------------------------------------------------------
--- /client/gui/wndtab_class.lua                        ---
--- Part of openFrame project                           ---
--- Written by 50p. Additional changes by Orange.       ---
--- Lately edited in revision number 13 by Orange       ---
--- Licensed under BSD licence                          ---
-----------------------------------------------------------

-- Class: WindowAndTab Class
-- Class which extends <Window Class> and <Tab Class>
WindowAndTab = {  };
WindowAndTab.__index = WindowAndTab;

--	Function: WindowAndTab:AddButton
--	Creates a button in Window or Tab
--	
--	Required Arguments:
--	   x - (float/integer) Space from left side of screen/window
--     y - (float/integer) Space from top side of screen/window
--     width - (float/integer) Width of the button
--     height - (float/integer) Height of the button
--     text - (string) Text placed on the button
--
--  Optional arguments:
--     relative - (bool) Are the x/y/width/height values relative?
--	   
--	Returns:
--		The result is button object
function WindowAndTab:AddButton( x, y, width, height, text, relative )
	if ( type( self ) ~= "table" ) then
		outputDebugString( "calling method incorrectly ( object.method() )! use object:method()", 1 );
		return false
	end
	local temp = Button:Create( x, y, width, height, text, relative, self.gui );
	if temp then
		table.insert( self.buttons, temp );
		return temp
	end
	return false;
end

function WindowAndTab:AddScrollPane( x, y, width, height, relative )
	if ( type( self ) ~= "table" ) then
		outputDebugString( "calling method incorrectly ( object.method() )! use object:method()", 1 );
		return false
	end
	local temp = ScrollPane:Create( x, y, width, height, relative, self.gui );
	if temp then
		--table.insert( self.scrollpanes, temp );
		return temp
	end
	return false;
end

--	Function: WindowAndTab:AddCheckBox
--	Creates a checkbox in Window or Tab
--	
--	Required Arguments:
--	   x - (float/integer) Space from left side of screen/window
--     y - (float/integer) Space from top side of screen/window
--     width - (float/integer) Width of the checkbox
--     height - (float/integer) Height of the checkbox
--     text - (string) Text placed near the checkbox
--
--  Optional arguments:
--     selected - (bool) Is the checkbox selected?
--     relative - (bool) Are the x/y/width/height values relative?
--	   
--	Returns:
--		The result is checkbox object
function WindowAndTab:AddCheckBox( x, y, width, height, text, selected, relative )
	if ( type( self ) ~= "table" ) then
		outputDebugString( "calling method incorrectly ( object.method() )! use object:method()", 1 );
		return false
	end
	local temp = CheckBox:Create( x, y, width, height, text, selected, relative, self.gui );
	if temp then
		table.insert( self.checkboxes, temp );
		return temp
	end
	return false;
end

--	Function: WindowAndTab:AddGridList
--	Creates a gridlist in Window or Tab
--	
--	Required Arguments:
--	   x - (float/integer) Space from left side of screen/window
--     y - (float/integer) Space from top side of screen/window
--     width - (float/integer) Width of the gridlist
--     height - (float/integer) Height of the gridlist
--
--  Optional arguments:
--     content - (table) Content of the gridlist
--     relative - (bool) Are the x/y/width/height values relative?
--	   
--	Returns:
--		The result is a gridlist object
function WindowAndTab:AddGridList( x, y, width, height, relative )
	if ( type( self ) ~= "table" ) then
		outputDebugString( "calling method incorrectly ( object.method() )! use object:method()", 1 );
		return false
	end
	local temp = GridList:Create( x, y, width, height, relative, self.gui );
	if temp then
		table.insert( self.gridlists, temp );
		return temp
	end
	return false;
end

--	Function: WindowAndTab:AddLabel
--	Creates a label in Window or Tab
--	
--	Required Arguments:
--	   x - (float/integer) Space from left side of screen/window
--     y - (float/integer) Space from top side of screen/window
--     width - (float/integer) Width of the label
--     height - (float/integer) Height of the label
--     text - (string) Text of the label
--
--  Optional arguments:
--     relative - (bool) Are the x/y/width/height values relative?
--	   
--	Returns:
--		The result is a label object
function WindowAndTab:AddLabel( x, y, width, height, text, relative )
	if ( type( self ) ~= "table" ) then
		outputDebugString( "calling method incorrectly ( object.method() )! use object:method()", 1 );
		return false
	end
	
	if type( width ) == "string" then
		relative = height;
		text = width;
		width = 2222;
		height = 2222;
	end
	local temp = Label:Create( x, y, width, height, text, relative, self.gui );
	if temp then
		table.insert( self.labels, temp );
		return temp
	end
	return false;
end

--	Function: WindowAndTab:AddMemo
--	Creates a memo in Window or Tab
--	
--	Required Arguments:
--	   x - (float/integer) Space from left side of screen/window
--     y - (float/integer) Space from top side of screen/window
--     width - (float/integer) Width of the memo
--     height - (float/integer) Height of the memo
--     text - (string) Text of the memo
--
--  Optional arguments:
--     relative - (bool) Are the x/y/width/height values relative?
--	   
--	Returns:
--		The result is a memo object
function WindowAndTab:AddMemo( x, y, width, height, text, relative )
	if ( type( self ) ~= "table" ) then
		outputDebugString( "calling method incorrectly ( object.method() )! use object:method()", 1 );
		return false
	end
	local temp = Memo:Create( x, y, width, height, text, relative, self.gui );
	if temp then
		table.insert( self.memos, temp );
		return temp
	end
	return false;
end

--	Function: WindowAndTab:AddProgressBar
--	Creates a progressbar in Window or Tab
--	
--	Required Arguments:
--	   x - (float/integer) Space from left side of screen/window
--     y - (float/integer) Space from top side of screen/window
--     width - (float/integer) Width of the progressbar
--     height - (float/integer) Height of the progressbar
--
--  Optional arguments:
--     text - (string) Text of the progressbar's caption
--     relative - (bool) Are the x/y/width/height values relative?
--	   
--	Returns:
--		The result is a progressbar object
function WindowAndTab:AddProgressBar( x, y, width, height, text, relative )
	if ( type( self ) ~= "table" ) then
		outputDebugString( "calling method incorrectly ( object.method() )! use object:method()", 1 );
		return false
	end
	local temp = ProgressBar:Create( x, y, width, height, text, relative, self.gui );
	if temp then
		table.insert( self.progressbars, temp );
		return temp
	end
	return false;
end

--	Function: WindowAndTab:AddRadioButton
--	Creates a radiobutton in Window or Tab
--	
--	Required Arguments:
--	   x - (float/integer) Space from left side of screen/window
--     y - (float/integer) Space from top side of screen/window
--     width - (float/integer) Width of the radiobutton
--     height - (float/integer) Height of the radiobutton
--     text - (string) Text placed near the radiobutton
--
--  Optional arguments:
--     selected - (bool) Is the checkbox selected?
--     relative - (bool) Are the x/y/width/height values relative?
--	   
--	Returns:
--		The result is radiobutton object
function WindowAndTab:AddRadioButton( x, y, width, height, text, selected, relative )
	if ( type( self ) ~= "table" ) then
		outputDebugString( "calling method incorrectly ( object.method() )! use object:method()", 1 );
		return false
	end
	local temp = RadioButton:Create( x, y, width, height, text, selected, relative, self.gui );
	if temp then
		table.insert( self.radiobuttons, temp );
		return temp
	end
	return false;
end

--	Function: WindowAndTab:AddScrollBar
--	Creates a scrollbar in Window or Tab
--	
--	Required Arguments:
--	   x - (float/integer) Space from left side of screen/window
--     y - (float/integer) Space from top side of screen/window
--     width - (float/integer) Width of the scrollbar
--     height - (float/integer) Height of the scrollbar
--     horizontal - (bool) Is the scrollbar horizontal?
--
--  Optional arguments:
--     relative - (bool) Are the x/y/width/height values relative?
--	   
--	Returns:
--		The result is scrollbar object
function WindowAndTab:AddScrollBar( x, y, width, height, horizontal, relative )
	if ( type( self ) ~= "table" ) then
		outputDebugString( "calling method incorrectly ( object.method() )! use object:method()", 1 );
		return false
	end
	local temp = ScrollBar:Create( x, y, width, height, horizontal, relative, self.gui );
	if temp then
		table.insert( self.scrollbars, temp );
		return temp
	end
	return false;
end

--	Function: WindowAndTab:AddStaticImage
--	Creates a image in Window or Tab
--	
--	Required Arguments:
--	   x - (float/integer) Space from left side of screen/window
--     y - (float/integer) Space from top side of screen/window
--     width - (float/integer) Width of the image
--     height - (float/integer) Height of the image
--     filename - (string) Filename of image to load
--
--  Optional arguments:
--     relative - (bool) Are the x/y/width/height values relative?
--	   
--	Returns:
--		The result is a StaticImage object
function WindowAndTab:AddStaticImage( x, y, width, height, filename, relative )
	if ( type( self ) ~= "table" ) then
		outputDebugString( "calling method incorrectly ( object.method() )! use object:method()", 1 );
		return false
	end
	local temp = StaticImage:Create( x, y, width, height, filename, relative, self.gui );
	if temp then
		table.insert( self.staticimages, temp );
		return temp
	end
	return false;
end

--	Function: WindowAndTab:AddTabPanel
--	Creates a tabpanel in Window or Tab
--	
--	Required Arguments:
--	   x - (float/integer) Space from left side of screen/window
--     y - (float/integer) Space from top side of screen/window
--     width - (float/integer) Width of the tabpanel
--     height - (float/integer) Height of the tabpanel
--
--  Optional arguments:
--     relative - (bool) Are the x/y/width/height values relative?
--	   
--	Returns:
--		The result is a tab panel.
function WindowAndTab:AddTabPanel( x, y, width, height, relative )
	if ( type( self ) ~= "table" ) then
		outputDebugString( "calling method incorrectly ( object.method() )! use object:method()", 1 );
		return false
	end
	local temp = TabPanel:Create( x, y, width, height, relative, self.gui );
	if temp then
		table.insert( self.tabpanels, temp );
		return temp
	end
	return false;
end

--	Function: WindowAndTab:AddTextBox
--	Creates a tabpanel in Window or Tab
--	
--	Required Arguments:
--	   x - (float/integer) Space from left side of screen/window
--     y - (float/integer) Space from top side of screen/window
--     width - (float/integer) Width of the textbox
--     height - (float/integer) Height of the textbox
--
--  Optional arguments:
--     text - (string) Default text of the textbox
--     relative - (bool) Are the x/y/width/height values relative?
--	   
--	Returns:
--		The result is a textbox object.
function WindowAndTab:AddTextBox( x, y, width, height, text, relative )
	if ( type( self ) ~= "table" ) then
		outputDebugString( "calling method incorrectly ( object.method() )! use object:method()", 1 );
		return false
	end
	local temp = TextBox:Create( x, y, width, height, text, relative, self.gui );
	if temp then
		table.insert( self.textboxes, temp );
		return temp
	end
	return false;
end
]])
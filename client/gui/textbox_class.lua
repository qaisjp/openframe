push([[
-----------------------------------------------------------
--- /client/gui/textbox_class.lua                       ---
--- Part of openFrame project                           ---
--- Written by 50p. Additional changes by Orange.       ---
--- Lately edited in revision number 13 by Orange       ---
--- Licensed under BSD licence                          ---
-----------------------------------------------------------

-- Class: TextBox Class
-- Class which allows to easily create textboxes.
TextBox = {  };
TextBox.__index = TextBox;

--	Function: TabPanel:Create
--	Creates a tabpanel
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
--     parent - (GUI) Parent of the image
--	   
--	Returns:
--		The result is a textbox object.
function TextBox:Create( x, y, width, height, text, relative, parent )
	local txtbox = {
		gui = false,
		masked = false,
		maxlength = 65536,
		readonly = false,
		onclick = { },
		onmouseenter = { },
		onmouseleave = { },
		cursorovergui = false
	};
	
	for i, f in pairs( GUISharedFuncs ) do
		if
		(
		  ( i ~= "__index" ) and
		  ( i ~= "Dragable" )
		)
		then
			txtbox[ i ] = f;
		end
	end

	txtbox.gui = guiCreateEdit( x, y, width, height, text, ( type( relative ) == "boolean" ) and relative or false, parent );
	if( txtbox.gui ) then
		setmetatable( txtbox, self );
		self.__index = self;
		
		addEventHandler( "onClientGUIClick", 
			txtbox.gui,
			function( mouseBtn, state, x, y )
				if type( txtbox.onclick ) == "table" then
					for i, f in pairs( txtbox.onclick ) do
						f( txtbox, mouseBtn, state, x, y );
					end
				end
			end, 
			false
		);
		addEventHandler( "onClientMouseEnter", 
			txtbox.gui,
			function( x, y )
				GUICollection.guiMouseIsOver = txtbox;
				if type( txtbox.onmouseenter ) == "table" then
					for _, f in pairs( txtbox.onmouseenter ) do
						if type( f ) == "function" then
							f( txtbox, x, y );
						end
					end
				end
			end, 
			false
		)
		addEventHandler( "onClientMouseLeave", 
			txtbox.gui,
			function( x, y )
				GUICollection.guiMouseIsOver = false; 
				if type( txtbox.onmouseleave ) == "table" then
					for _, f in pairs( txtbox.onmouseleave ) do
						if type( f ) == "function" then
							f( txtbox, x, y );
						end
					end
				end
			end, 
			false
		)

		return txtbox;
	end
	return false;
end

--	Function: TextBox:SetCaratIndex
--	Sets carat index
--
--  Required arguments:
--    index - (integer) Carat index to set
--	   
--	Returns:
--	   Returns carat index if tried to get. If tried to set - true if setted, false if not
function TextBox:SetCaratIndex( index )
	if ( type( self ) ~= "table" ) then
		outputDebugString( "calling method incorrectly ( object.method() )! use object:method()", 1 );
		return false
	end
	if ( type( index ) == "number" ) then
		return guiEditSetCaretIndex( self.gui, index );
	end
	return false;
end

--	Function: TextBox:Masked
--	Sets or gets the "masked" status of textbox.
--
--  Required arguments:
--    masking - (bool) State of textbox's masking to set
--	   
--	Returns:
--	   Returns masking status if tried to get. If tried to set - true if setted, false if not
function TextBox:Masked( masking )
	if ( type( self ) ~= "table" ) then
		outputDebugString( "calling method incorrectly ( object.method() )! use object:method()", 1 );
		return false
	end
	if ( type( masking ) == "boolean" ) then
		self.masked = masking;
		return guiEditSetMasked( self.gui, masking );
	end
	return self.masked;
end

--	Function: TextBox:MaxLength
--	Sets or gets the max length of textbox.
--
--  Required arguments:
--    maxlenght - (integer) Max lenght of textbox to set.
--	   
--	Returns:
--	   Returns max lenght if tried to get. If tried to set - true if setted, false if not
function TextBox:MaxLength( maxlength )
	if ( type( self ) ~= "table" ) then
		outputDebugString( "calling method incorrectly ( object.method() )! use object:method()", 1 );
		return false
	end
	if ( type( maxlength ) == "number" ) then
		self.maxlength = maxlength;
		return guiEditSetMaxLength( self.gui, maxlength );
	end
	return self.maxlength;
end

--	Function: TextBox:ReadOnly
--	Returns or sets the read-only property
--
--  Optional arguments:
--     readonly - (bool) State of the read-only property
--	   
--	Returns:
--	   If tried to set, true or false. If tried to get it, returns current state.
function TextBox:ReadOnly( readonly )
	if ( type( self ) ~= "table" ) then
		outputDebugString( "calling method incorrectly ( object.method() )! use object:method()", 1 );
		return false
	end
	if ( type( readonly ) == "boolean" ) then
		self.readonly = readonly;
		return guiEditSetReadOnly( self.gui, readonly );
	end
	return self.readonly;
end
]])
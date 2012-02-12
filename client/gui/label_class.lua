push([[
-----------------------------------------------------------
--- /client/gui/label_class.lua                         ---
--- Part of openFrame project                           ---
--- Written by 50p. Additional changes by Orange.       ---
--- Lately edited in revision number 13 by Orange       ---
--- Licensed under BSD licence                          ---
-----------------------------------------------------------

-- Class: Label Class
-- Class which allows to easily add label to windows/screen.
Label = {  };
Label.__index = Label;

--	Function: Label:Create
--	Creates a label
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
--     parent - (GUI) Parent of the label
--	   
--	Returns:
--		The result is a label object
function Label:Create( x, y, width, height, text, relative, parent )
	local label = {
		gui = false,
		r = 255,
		g = 255,
		b = 255,
		verticalAlign = "top",
		horizontalAlign = "left",
		onclick = { },
		onmouseenter = { },
		onmouseleave = { },
		cursorovergui = false
	};
	
	for i, f in pairs( GUISharedFuncs ) do
		if ( i ~= "__index" ) then
			label[ i ] = f;
		end
	end
	
	if type( width ) == "string" then
		relative = height;
		parent = text;
		text = width;
		width = 2222;
		height = 2222;
	end
	label.gui = guiCreateLabel( x, y, width, height, text, ( type( relative ) == "boolean" ) and relative or false, parent );
	if( label.gui ) then
		setmetatable( label, self );
		self.__index = self;
		addEventHandler( "onClientMouseEnter", label.gui, function( ) GUICollection.guiMouseIsOver = label;  end, false );
		addEventHandler( "onClientMouseLeave", label.gui, function( ) GUICollection.guiMouseIsOver = false;  end, false );
		addEventHandler( "onClientGUIClick", 
			label.gui,
			function( mouseBtn, state, x, y )
				if type( label.onclick ) == "table" then
					for i, f in pairs( label.onclick ) do
						f( label, mouseBtn, state, x, y );
					end
				end
			end, 
			false
		);
		addEventHandler( "onClientMouseEnter", 
			label.gui,
			function( x, y )
				if type( label.onmouseenter ) == "table" then
					for _, f in pairs( label.onmouseenter ) do
						if type( f ) == "function" then
							f( label, x, y );
						end
					end
				end
			end, 
			false
		)
		addEventHandler( "onClientMouseLeave", 
			label.gui,
			function( x, y )
				if type( label.onmouseleave ) == "table" then
					for _, f in pairs( label.onmouseleave ) do
						if type( f ) == "function" then
							f( label, x, y );
						end
					end
				end
			end, 
			false
		)
		
		if ( ( width == 2222 ) and ( height == 2222 ) ) then
			label:Size( label:GetTextExtent(), label:GetFontHeight( ) );
		end
		return label;
	end
	return false;
end

--	Function: Label:Color
--	Returns or sets the color of label.
--
--  Optional arguments:
--     r - (integer) Value of red color
--     g - (integer) Value of green color
--     b - (integer) Value of blue color
--	   
--	Returns:
--	   If tried to set, true or false. If tried to get, three integers with values.
function Label:Color( r, g, b )
	if ( type( self ) ~= "table" ) then
		outputDebugString( "calling method incorrectly ( object.method() )! use object:method()", 1 );
		return false
	end
	if ( type( r ) == "number" ) and ( type( g ) == "number" ) and ( type( b ) == "number" ) then
		if guiLabelSetColor( self.gui, r, g, b ) then
			self.r, self.g, self.b = r, g, b;
			return true;
		end
	end
	return self.r, self.g, self.b;
end

--	Function: Label:VerticalAlign
--	Returns or sets the vertical align parameter
--
--  Optional arguments:
--     align - (string) Value of the vertical align parameter
--	   
--	Returns:
--	   If tried to set, true or false. If tried to get it, returns current value.
function Label:VerticalAlign( align )
	if ( type( self ) ~= "table" ) then
		outputDebugString( "calling method incorrectly ( object.method() )! use object:method()", 1 );
		return false
	end
	if ( type( align ) == "string" ) then
		if guiLabelSetVerticalAlign( self.gui, align ) then
			self.verticalAlign = align;
			return true;
		end
	end
	return self.verticalAlign;
end

--	Function: Label:HorizontalAlign
--	Returns or sets the horizontal align parameter
--
--  Optional arguments:
--     align - (string) Value of the horizontal align parameter
--	   
--	Returns:
--	   If tried to set, true or false. If tried to get it, returns current value.
function Label:HorizontalAlign( align )
	if ( type( self ) ~= "table" ) then
		outputDebugString( "calling method incorrectly ( object.method() )! use object:method()", 1 );
		return false
	end
	if ( type( align ) == "string" ) then
		if guiLabelSetHorizontalAlign( self.gui, align ) then
			self.horizontalAlign = align;
			return true;
		end
	end
	return self.horizontalAlign;
end

--	Function: Label:GetTextExtent
--	Returns the text extent.
--	   
--	Returns:
--	   Returns current text extent.
function Label:GetTextExtent( )
	if ( type( self ) ~= "table" ) then
		outputDebugString( "calling method incorrectly ( object.method() )! use object:method()", 1 );
		return false
	end
	return guiLabelGetTextExtent( self.gui );
end

--	Function: Label:GetFontHeight
--	Returns font height.
--	   
--	Returns:
--	   Returns font height.
function Label:GetFontHeight( )
	if ( type( self ) ~= "table" ) then
		outputDebugString( "calling method incorrectly ( object.method() )! use object:method()", 1 );
		return false
	end
	return guiLabelGetFontHeight( self.gui );
end
]])
push([[
-----------------------------------------------------------
--- /client/gui/sharedfuncs_class.lua                   ---
--- Part of openFrame project                           ---
--- Written by 50p. Additional changes by Orange.       ---
--- Lately edited in revision number 13 by Orange       ---
--- Licensed under BSD licence                          ---
-----------------------------------------------------------

-- Class: GUISharedFuncs Class
-- Class which extends all GUI classes.
GUISharedFuncs = { }
GUISharedFuncs.__index = GUISharedFuncs;

--	Function: GUISharedFuncs:Alpha
--	Returns or sets the alpha of GUI element.
--
--  Optional arguments:
--     alpha - (integer) Alpha value (0-255)
--	   
--	Returns:
--	   If tried to set, true or false. If tried to get, an integer with opacity level (0-255).
function GUISharedFuncs:Alpha( alpha )
	if ( type( self ) ~= "table" ) then
		outputDebugString( "calling method incorrectly ( object.method() )! use object:method()", 1 );
		return false
	end
	if type( alpha ) == "number" then
		return guiSetAlpha( self.gui, alpha );
	end
	return guiGetAlpha( self.gui );
end

--	Function: GUISharedFuncs:BringToFront
--	Brings GUI element to front
--	   
--	Returns:
--	   Returns true if brought, false if not
function GUISharedFuncs:BringToFront( )
	if ( type( self ) ~= "table" ) then
		outputDebugString( "calling method incorrectly ( object.method() )! use object:method()", 1 );
		return false
	end
	return guiBringToFront( self.gui );
end

--	Function: GUISharedFuncs:Dragable
--	Returns or sets the "dragable" state.
--
--  Optional arguments:
--     dragable - (bool) Dragable state to set
--	   
--	Returns:
--	   If tried to set, true or false. If tried to get, boolean with current state
function GUISharedFuncs:Dragable( dragable )
	if ( type( self ) ~= "table" ) then
		outputDebugString( "calling method incorrectly ( object.method() )! use object:method()", 1 );
		return false
	end
	if type( dragable ) == "boolean" then
		self._dragable = dragable;
		return true;
	end
	return self._dragable;
end

--	Function: GUISharedFuncs:Enabled
--	Returns or sets tthe "enabled" state.
--
--  Optional arguments:
--     enabled - (bool) Enabled state to set
--	   
--	Returns:
--	   If tried to set, true or false. If tried to get, boolean with current state
function GUISharedFuncs:Enabled( enabled )
	if ( type( self ) ~= "table" ) then
		outputDebugString( "calling method incorrectly ( object.method() )! use object:method()", 1 );
		return false
	end
	if type( enabled ) == "boolean" then
		return guiSetEnabled( self.gui, enabled )
	end
	return guiGetEnabled( self.gui );
end

--	Function: GUISharedFuncs:Font
--	Returns or sets the font of GUI element.
--
--  Optional arguments:
--     font - (string) Font name to set
--	   
--	Returns:
--	   If tried to set, true or false. If tried to get, an string with font name.
function GUISharedFuncs:Font( newfont )
	if ( type( self ) ~= "table" ) then
		outputDebugString( "calling method incorrectly ( object.method() )! use object:method()", 1 );
		return false
	end
	if type( newfont ) == "string" then
		return guiSetFont( self.gui, newfont );
	end
	return guiGetFont( self.gui )
end

--	Function: GUISharedFuncs:MoveToBack
--	Moves GUI element to back
--	   
--	Returns:
--	   Returns true if moved, false if not
function GUISharedFuncs:MoveToBack( )
	if ( type( self ) ~= "table" ) then
		outputDebugString( "calling method incorrectly ( object.method() )! use object:method()", 1 );
		return false
	end
	return guiMoveToBack( self.gui );
end

--	Function: GUISharedFuncs:Property
--	Returns or sets specified property.
--
--  Optional arguments:
--     property - (string) Name of the property to set
--     value - (string) Value of the property to set
--	   
--	Returns:
--	   If tried to set, true or false. If tried to get, boolean with the value.
function GUISharedFuncs:Property( property, value )
	if ( type( self ) ~= "table" ) then
		outputDebugString( "calling method incorrectly ( object.method() )! use object:method()", 1 );
		return false
	end
	if
	(
	 ( type( property ) == "string" ) and
	 ( type( value ) == "string" )
	)
	then
		return guiSetProperty( self.gui, property, value );
	end
	return guiGetProperty( self.gui, property );
end

--	Function: GUISharedFuncs:Text
--	Returns or sets the text of GUI element.
--
--  Optional arguments:
--     text - (string) Text to set
--	   
--	Returns:
--	   If tried to set, true or false. If tried to get, an string with text
function GUISharedFuncs:Text( value )
	if ( type( self ) ~= "table" ) then
		outputDebugString( "calling method incorrectly ( object.method() )! use object:method()", 1 );
		return false
	end
	if type( value ) == "string" then
		local oldText = guiGetText( self.gui );
		if 
		 (
		 ( guiSetText( self.gui, value ) ) and
		 ( type( self.ontextchanged ) == "function" ) and
		 ( oldText ~= value )
		 )
		then
			self.ontextchanged( self, oldText, value );
		end
	end
	return guiGetText( self.gui );
end

--	Function: GUISharedFuncs:Position
--	Returns or sets the position of GUI element
--
--  Optional arguments:
--     x - (float/integer) Space between left side of screen/window and GUI element
--     y - (float/integer) Space between top side of screen/window and GUI element
--     relative - (bool) Is x and y relative value?
--	   
--	Returns:
--	   If tried to set, true or false. If tried to get, two integers with position.
function GUISharedFuncs:Position( x, y, relative )
	if ( type( self ) ~= "table" ) then
		outputDebugString( "calling method incorrectly ( object.method() )! use object:method()", 1 );
		return false
	end
	if ( type( x ) == "number" ) and ( type( y ) == "number" ) then
		return guiSetPosition( self.gui, x, y, ( type( x ) == "boolean" ) and x or false )
	end
	return guiGetPosition( self.gui, ( type( x ) == "boolean" ) and x or false );
end

--	Function: GUISharedFuncs:Size
--	Returns or sets the size of GUI element
--
--  Optional arguments:
--     width - (float/integer) Width of GUI element.
--     height - (float/integer) Height of GUI element.
--     relative - (bool) Is x and y relative value?
--	   
--	Returns:
--	   If tried to set, true or false. If tried to get, two integers with size.
function GUISharedFuncs:Size( width, height, relative )
	if ( type( self ) ~= "table" ) then
		outputDebugString( "calling method incorrectly ( object.method() )! use object:method()", 1 );
		return false
	end
	if ( type( width ) == "number" ) and ( type( height ) == "number" ) then
		return guiSetSize( self.gui, width, height, ( type( relative ) == "boolean" ) and relative or false )
	end
	return guiGetSize( self.gui, ( type( width ) == "boolean" ) and width or false )
end

--	Function: GUISharedFuncs:Visible
--	Returns the "visible" state of GUI element or sets it
--
--  Optional arguments:
--     visible - (bool) Make GUI element visible/not visible?
--	   
--	Returns:
--	   If tried to set, true or false. If tried to get, boolean with visiblity state.
function GUISharedFuncs:Visible( visible )
	if ( type( self ) ~= "table" ) then
		outputDebugString( "calling method incorrectly ( object.method() )! use object:method()", 1 );
		return false
	end
	if type( visible ) == "boolean" then
		return guiSetVisible( self.gui, visible )
	end
	return guiGetVisible( self.gui );
end


--	Function: GUISharedFuncs:AddOnClick
--	Adds an event for clicking GUI element.
--
--  Required arguments:
--     func - (function) Function to trigger after clicking.
--	   
--	Returns:
--	   Returns true if added, false if not.
function GUISharedFuncs:AddOnClick( func )
	if ( type( self ) ~= "table" ) then
		outputDebugString( "calling method incorrectly ( object.method() )! use object:method()", 1 );
		return false
	end
	if type( func ) == "function" then
		table.insert( self.onclick, func );
		return true;
	end
	return false;
end

--	Function: GUISharedFuncs:RemoveOnClick
--	Removes an event for clicking GUI element.
--
--  Required arguments:
--     func - (function) Function to remove.
--	   
--	Returns:
--	   Returns true if removed, false if not.
function GUISharedFuncs:RemoveOnClick( func )
	if ( type( self ) ~= "table" ) then
		outputDebugString( "calling method incorrectly ( object.method() )! use object:method()", 1 );
		return false
	end
	if type( func ) == "function" then
		for i, f in pairs( self.onclick ) do
			if f == func then
				table.remove( self.onclick, i );
				return true;
			end
		end
	end
	return false;
end

--	Function: GUISharedFuncs:AddOnMouseEnter
--	Adds an event for moving mouse on a GUI element.
--
--  Required arguments:
--     func - (function) Function to trigger after moving mouse on a GUI element.
--	   
--	Returns:
--	   Returns true if added, false if not.
function GUISharedFuncs:AddOnMouseEnter( func )
	if ( type( self ) ~= "table" ) then
		outputDebugString( "calling method incorrectly ( object.method() )! use object:method()", 1 );
		return false
	end
	if type( func ) == "function" then
		table.insert( self.onmouseenter, func );
		return true;
	end
	return false;
end

--	Function: GUISharedFuncs:RemoveOnMouseEnter
--	Removes an event for moving mouse on a GUI element.
--
--  Required arguments:
--     func - (function) Function to remove, triggered when moving mouse on a GUI element.
--	   
--	Returns:
--	   Returns true if removed, false if not.
function GUISharedFuncs:RemoveOnMouseEnter( func )
	if ( type( self ) ~= "table" ) then
		outputDebugString( "calling method incorrectly ( object.method() )! use object:method()", 1 );
		return false
	end
	if type( func ) == "function" then
		for i, f in pairs( self.onmouseenter ) do
			if f == func then
				table.remove( self.onmouseenter, i );
				return true;
			end
		end
	end
	return false;
end

--	Function: GUISharedFuncs:AddOnMouseLeave
--	Adds an event for moving mouse off of a GUI element.
--
--  Required arguments:
--     func - (function) Function to trigger after moving mouse off of a GUI element.
--	   
--	Returns:
--	   Returns true if added, false if not.
function GUISharedFuncs:AddOnMouseLeave( func )
	if ( type( self ) ~= "table" ) then
		outputDebugString( "calling method incorrectly ( object.method() )! use object:method()", 1 );
		return false
	end
	if type( func ) == "function" then
		table.insert( self.onmouseleave, func );
		return true;
	end
	return false;
end

--	Function: GUISharedFuncs:RemoveOnMouseLeave
--	Removes an event for moving mouse off of a GUI element.
--
--  Required arguments:
--     func - (function) Function to remove, triggered when moving mouse off of a GUI element.
--	   
--	Returns:
--	   Returns true if removed, false if not.
function GUISharedFuncs:RemoveOnMouseLeave( func )
	if ( type( self ) ~= "table" ) then
		outputDebugString( "calling method incorrectly ( object.method() )! use object:method()", 1 );
		return false
	end
	if type( func ) == "function" then
		for i, f in pairs( self.onmouseleave ) do
			if f == func then
				table.remove( self.onmouseleave, i );
				return true;
			end
		end
	end
	return false;
end

function GUISharedFuncs:Destroy()
	if ( type( self ) ~= "table" ) then
		outputDebugString( "calling method incorrectly ( object.method() )! use object:method()", 1 );
		return false
	end
	if destroyElement(self.gui) then
		return true;
	end
	return false;
end


]])
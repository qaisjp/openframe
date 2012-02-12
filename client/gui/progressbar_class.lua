push([[
-----------------------------------------------------------
--- /client/gui/progressbar_class.lua                   ---
--- Part of openFrame project                           ---
--- Written by 50p. Additional changes by Orange.       ---
--- Lately edited in revision number 13 by Orange       ---
--- Licensed under BSD licence                          ---
-----------------------------------------------------------

-- Class: ProgressBar Class
-- Class which allows to easily add progressbars to windows/screen.
ProgressBar = {  };
ProgressBar.__index = ProgressBar;

--	Function: ProgressBar:Create
--	Creates a progressbar
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
--     parent - (GUI) Parent of the progressbar
--	   
--	Returns:
--		The result is a progressbar object
function ProgressBar:Create( x, y, width, height, text, relative, parent )
	local progbar = {
		gui = false,
		lbl = false,
		onclick = { },
		onmouseenter = { },
		onmouseleave = { },
		cursorovergui = false,
		_dragable = false
	};
	
	for i, f in pairs( GUISharedFuncs ) do
		if
		(
		  ( i ~= "__index" ) and 
		  ( i ~= "Dragable" ) and
		  ( i ~= "Font" ) and
		  ( i ~= "Text" ) and
		  ( i ~= "Size" ) 
		)
		then
			progbar[ i ] = f;
		end
	end
	
	if type( text ) == "boolean" then
		relative = text;
	end
	
	progbar.gui = guiCreateProgressBar( x, y, width, height, ( type( relative ) == "boolean" ) and relative or false, parent );
	if( progbar.gui ) then
		if type( text ) == "string" then
			progbar.lbl = Label:Create( 0, 0, width, height, text or "", ( type( relative ) == "boolean" ) and relative or false, progbar.gui );
			progbar.lbl:VerticalAlign( "center" );
			progbar.lbl:HorizontalAlign( "center" );
			progbar.lbl:Color( 255, 255, 0 );
		end
		setmetatable( progbar, self );
		self.__index = self;
		addEventHandler( "onClientGUIClick", 
			( type( progbar.lbl ) == "table" ) and progbar.lbl.gui or progbar.gui,
			function( mouseBtn, state, x, y )
				if type( progbar.onclick ) == "table" then
					for i, f in pairs( progbar.onclick ) do
						f( progbar, mouseBtn, state, x, y );
					end
				end
			end, 
			false
		);
		addEventHandler( "onClientMouseEnter", 
			( type( progbar.lbl ) == "table" ) and progbar.lbl.gui or progbar.gui,
			function( x, y )
				GUICollection.guiMouseIsOver = progbar;
				if type( progbar.onmouseenter ) == "table" then
					for _, f in pairs( progbar.onmouseenter ) do
						if type( f ) == "function" then
							f( progbar, x, y );
						end
					end
				end
			end, 
			false
		)
		addEventHandler( "onClientMouseLeave", 
			( type( progbar.lbl ) == "table" ) and progbar.lbl.gui or progbar.gui,
			function( x, y )
				GUICollection.guiMouseIsOver = false; 
				if type( progbar.onmouseleave ) == "table" then
					for _, f in pairs( progbar.onmouseleave ) do
						if type( f ) == "function" then
							f( progbar, x, y );
						end
					end
				end
			end, 
			false
		)

		return progbar;
	end
	return false;
end

--	Function: ProgressBar:Font
--	Returns or sets the font
--
--  Optional arguments:
--     newfont - (string) The new font name
--	   
--	Returns:
--	   If tried to set, true or false. If tried to get it, returns current font.
function ProgressBar:Font( newfont )
	if ( type( self ) ~= "table" ) then
		outputDebugString( "calling method incorrectly ( object.method() )! use object:method()", 1 );
		return false
	end
	if type( newfont ) == "string" then
		if type( self.lbl ) == "table" then
			return self.lbl:Font( newfont );
		end
		outputDebugString( "this progressbar doesn't have a label!", 0 );
		return false;
	end
	return guiGetFont( self.gui )
end

--	Function: ProgressBar:LabelColor
--	Returns or sets the color of progressbar's label.
--
--  Optional arguments:
--     r - (integer) Value of red color
--     g - (integer) Value of green color
--     b - (integer) Value of blue color
--	   
--	Returns:
--	   If tried to set, true or false. If tried to get, three integers with values.
function ProgressBar:LabelColor( r, g, b )
	if ( type( self ) ~= "table" ) then
		outputDebugString( "calling method incorrectly ( object.method() )! use object:method()", 1 );
		return false
	end
	if
	(
	  ( type( r ) == "number" ) and
	  ( type( g ) == "number" ) and
	  ( type( b ) == "number" )
	)
	then
		if type( self.lbl ) == "table" then
			return self.lbl:Color( r, g, b );
		end
		outputDebugString( "this progressbar doesn't have a label!", 0 );
		return false;
	end
	return guiGetText( self.gui );
end

--	Function: ProgressBar:Progress
--	Returns or sets the progress
--
--  Optional arguments:
--     progress - (integer) Current progress displayed on progressbar
--	   
--	Returns:
--	   If tried to set, true or false. If tried to get it, returns current progress.
function ProgressBar:Progress( progress )
	if ( type( self ) ~= "table" ) then
		outputDebugString( "calling method incorrectly ( object.method() )! use object:method()", 1 );
		return false
	end
	if ( type( progress ) == "number" ) then
		return guiProgressBarSetProgress( self.gui, progress );
	end
	return guiProgressBarGetProgress( self.gui );
end

--	Function: ProgressBar:Text
--	Returns or sets the progressbar's text
--
--  Optional arguments:
--     text - (string) Progressbar's text to set
--	   
--	Returns:
--	   If tried to set, true or false. If tried to get it, returns current text.
function ProgressBar:Text( value )
	if ( type( self ) ~= "table" ) then
		outputDebugString( "calling method incorrectly ( object.method() )! use object:method()", 1 );
		return false
	end
	if type( value ) == "string" then
		if type( self.lbl ) == "table" then
			return self.lbl:Text( value );
		end
		outputDebugString( "this progressbar doesn't have a label!", 0 );
		return false;
	end
	return guiGetText( self.gui );
end

--	Function: ProgressBar:Size
--	Returns or sets the progressbar's size
--
--  Optional arguments:
--     width - (string) New width to set
--     height - (string) New height to set
--     relative - (bool) Is width and height relative?
--	   
--	Returns:
--	   If tried to set, true or false. If tried to get it, returns current size.
function ProgressBar:Size( width, height, relative )
	if ( type( self ) ~= "table" ) then
		outputDebugString( "calling method incorrectly ( object.method() )! use object:method()", 1 );
		return false
	end
	if ( type( width ) == "number" ) and ( type( height ) == "number" ) then
		local temp = guiSetSize( self.gui, width, height, ( type( relative ) == "boolean" ) and relative or false );
		if temp then
			if type( self.lbl ) == "table" then
				self.lbl:Size( 1, 1, true );
			end
			return temp;
		end
	end
	return guiGetSize( self.gui, ( type( width ) == "boolean" ) and width or false )
end

]])
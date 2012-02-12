push([[
-----------------------------------------------------------
--- /client/gui/staticimage_class.lua                   ---
--- Part of openFrame project                           ---
--- Written by 50p. Additional changes by Orange.       ---
--- Lately edited in revision number 13 by Orange       ---
--- Licensed under BSD licence                          ---
-----------------------------------------------------------

-- Class: StaticImage Class
-- Class which allows to easily add images to windows/screen.
StaticImage = {  };
StaticImage.__index = StaticImage;

--	Function: StaticImage:Create
--	Creates a image
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
--     parent - (GUI) Parent of the image
--	   
--	Returns:
--		The result is a StaticImage object
function StaticImage:Create( x, y, width, height, filename, relative, parent )
	local staticimg = {
		gui = false,
		onclick = { },
		onmouseenter = { },
		onmouseleave = { },
		cursorovergui = false
	};
	
	for i, f in pairs( GUISharedFuncs ) do
		if
		(
		  ( i ~= "__index" ) and
		  ( i ~= "Text" ) and
		  ( i ~= "Font" )
		)
		then
			staticimg[ i ] = f;
		end
	end
	
	staticimg.gui = guiCreateStaticImage( x, y, width, height, filename, ( type( relative ) == "boolean" ) and relative or false, parent );
	if( staticimg.gui ) then
		setmetatable( staticimg, self );
		self.__index = self;
		addEventHandler( "onClientGUIClick", 
			staticimg.gui,
			function( mouseBtn, state, x, y )
				if type( staticimg.onclick ) == "table" then
					for i, f in pairs( staticimg.onclick ) do
						f( staticimg, mouseBtn, state, x, y );
					end
				end
			end, 
			false
		);
		addEventHandler( "onClientMouseEnter", 
			staticimg.gui,
			function( x, y )
				GUICollection.guiMouseIsOver = staticimg;
				if type( staticimg.onmouseenter ) == "table" then
					for _, f in pairs( staticimg.onmouseenter ) do
						if type( f ) == "function" then
							f( staticimg, x, y );
						end
					end
				end
			end, 
			false
		)
		addEventHandler( "onClientMouseLeave", 
			staticimg.gui,
			function( x, y )
				GUICollection.guiMouseIsOver = false; 
				if type( staticimg.onmouseleave ) == "table" then
					for _, f in pairs( staticimg.onmouseleave ) do
						if type( f ) == "function" then
							f( staticimg, x, y );
						end
					end
				end
			end, 
			false
		)

		return staticimg;
	end
	return false;
end

--	Function: StaticImage:LoadImage
--	Loads an image into existing one
--
--  Required arguments:
--     filename - (string) Filename of an image to load
--	   
--	Returns:
--	   True if loaded, false if not.
function StaticImage:LoadImage( filename )
	if ( type( self ) ~= "table" ) then
		outputDebugString( "calling method incorrectly ( object.method() )! use object:method()", 1 );
		return false
	end
	if ( type( filename ) == "string" ) then
		return guiStaticImageLoadImage( self.gui, filename );
	end
	return false;
end
]])
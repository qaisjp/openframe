push([[
-----------------------------------------------------------
--- /client/gui/GUICollection.lua                       ---
--- Part of openFrame project                           ---
--- Written by 50p. Additional changes by Orange.       ---
--- Lately edited in revision number 13 by Orange       ---
--- Licensed under BSD licence                          ---
-----------------------------------------------------------

sx, sy = guiGetScreenSize()

-- Class: GUICollection Class
-- Class which combines every GUI classes
GUICollection = { 
	buttons = 		{  },
	checkboxes = 	{  },
	editfields = 	{  },
	gridlists = 	{  },
	labels = 		{  },
	memos = 		{  },
	progressbars = 	{  },
	radiobuttons = 	{  },
	scrollbars = 	{  },
	staticimages = 	{  },
	tabpanels = 	{  },
	tabs = 			{  },
	windows =		{  },
	guiMouseIsOver = 	false,
	guiMouseIsClicked = false,
};
GUICollection.__index = GUICollection;


addEventHandler ( "onClientClick", getRootElement(),
	function( btn, state, x, y )
		local screenSize = { guiGetScreenSize() };
		if state == "down" and btn == "left" then
			if 
			  ( GUICollection.guiMouseIsOver ) and 
			  ( GUICollection.guiMouseIsOver.Dragable ) and 
			  ( GUICollection.guiMouseIsOver:Dragable() ) 
			then
				GUICollection.guiMouseIsClicked = GUICollection.guiMouseIsOver.gui;
				x = x / screenSize[ 1 ];
				y = y / screenSize[ 2 ];
				local xx, yy = guiGetPosition( GUICollection.guiMouseIsOver.gui, true );
				GUICollection.guiMouseClickedXY = { x - xx, y - yy }
			end
		elseif state == "up" then
			GUICollection.guiMouseIsClicked = false;
		end
	end
)

addEventHandler( "onClientCursorMove", getRootElement(),
	function( x, y ) 
		if ( ( GUICollection.guiMouseIsOver ) and ( GUICollection.guiMouseIsClicked ) ) then
			local parent = getElementParent( GUICollection.guiMouseIsClicked );
			if getElementType( parent ) == "guiroot" then
				guiSetPosition( GUICollection.guiMouseIsOver.gui, x-GUICollection.guiMouseClickedXY[ 1 ], y-GUICollection.guiMouseClickedXY[ 2 ], true );
			end
		end
	end
);

--	Function: print
--	Prints text
--	
--	Required Arguments:
--  	... - anything
--	   
--	Returns:
--		The result is nothing
function print( ... )
	local str = "";
	for i = 1, #arg do
		if i == #arg then
			str = str .. tostring( arg[ i ] )
		else
			str = str .. tostring( arg[ i ] ) ..", "
		end
	end
	outputDebugString( str );
end
]])
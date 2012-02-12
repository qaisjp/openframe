push([[
-----------------------------------------------------------
--- /client/gui/memo_class.lua                          ---
--- Part of openFrame project                           ---
--- Written by 50p. Additional changes by Orange.       ---
--- Lately edited in revision number 13 by Orange       ---
--- Licensed under BSD licence                          ---
-----------------------------------------------------------

-- Class: Memo Class
-- Class which allows to easily add memo to windows/screen.
Memo = {  };
Memo.__index = Memo;

--	Function: Memo:Create
--	Creates a memo
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
--     parent - (GUI) Parent of the memo
--	   
--	Returns:
--		The result is a memo object
function Memo:Create( x, y, width, height, text, relative, parent )
	local memo = {
		gui = false,
		onclick = { },
		onmouseenter = { },
		onmouseleave = { },
		cursorovergui = falses
	};
	
	for i, f in pairs( GUISharedFuncs ) do
		if
		(
		  ( i ~= "__index" ) and
		  ( i ~= "Dragable" ) 
		)
		then
			memo[ i ] = f;
		end
	end
	
	memo.gui = guiCreateMemo( x, y, width, height, text, ( type( relative ) == "boolean" ) and relative or false, parent );
	if( memo.gui ) then
		setmetatable( memo, self );
		self.__index = self;
		addEventHandler( "onClientMouseEnter", memo.gui, function( ) GUICollection.guiMouseIsOver = memo;  end, false );
		addEventHandler( "onClientMouseLeave", memo.gui, function( ) GUICollection.guiMouseIsOver = false;  end, false );
		addEventHandler( "onClientGUIClick", 
			memo.gui,
			function( mouseBtn, state, x, y )
				if type( memo.onclick ) == "table" then
					for i, f in pairs( memo.onclick ) do
						f( memo, mouseBtn, state, x, y );
					end
				end
			end, 
			false
		);
		addEventHandler( "onClientMouseEnter", 
			memo.gui,
			function( x, y )
				if type( memo.onmouseenter ) == "table" then
					for _, f in pairs( memo.onmouseenter ) do
						if type( f ) == "function" then
							f( memo, x, y );
						end
					end
				end
			end, 
			false
		)
		addEventHandler( "onClientMouseLeave", 
			memo.gui,
			function( x, y )
				if type( memo.onmouseleave ) == "table" then
					for _, f in pairs( memo.onmouseleave ) do
						if type( f ) == "function" then
							f( memo, x, y );
						end
					end
				end
			end, 
			false
		)

		return memo;
	end
	return false;
end

--	Function: Memo:SetCaretIndex
--	Sets caret index
--
--  Required arguments:
--    index - (integer) Caret index to set
--	   
--	Returns:
--	   Returns true if setted, false if not
function Memo:SetCaretIndex( index )
	if ( type( self ) ~= "table" ) then
		outputDebugString( "calling method incorrectly ( object.method() )! use object:method()", 1 );
		return false
	end
	if ( type( index ) == "number" ) then
		return guiMemoSetCaretIndex( self.gui, index );
	end
	return false;
end

--	Function: Memo:ReadOnly
--	Returns or sets the read-only property
--
--  Optional arguments:
--     readonly - (bool) State of the read-only property
--	   
--	Returns:
--	   If tried to set, true or false. If tried to get it, returns current state.
function Memo:ReadOnly( readonly )
	if ( type( self ) ~= "table" ) then
		outputDebugString( "calling method incorrectly ( object.method() )! use object:method()", 1 );
		return false
	end
	if ( type( readonly ) == "boolean" ) then
		self.readonly = readonly;
		return guiMemoSetReadOnly( self.gui, readonly );
	end
	return self.readonly;
end

]])
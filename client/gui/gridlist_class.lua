push([[
-----------------------------------------------------------
--- /client/gui/gridlist_class.lua                      ---
--- Part of openFrame project                           ---
--- Written by 50p. Additional changes by Orange.       ---
--- Lately edited in revision number 13 by Orange       ---
--- Licensed under BSD licence                          ---
-----------------------------------------------------------

-- Class: GridList Class
-- Class which allows to easily add gridlists to windows/screen.
GridList = {  };
GridList.__index = GridList;

--	Function: GridList:Create
--	Creates a gridlist
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
--     parent - (GUI) Parent of the gridlist
--	   
--	Returns:
--		The result is a gridlist object
function GridList:Create( x, y, width, height, content, relative, parent )
	local gridlist = {
		gui = false,
		sorting = true,
		horizontalBar = false,
		verticalBar = false,
		selectionmode = 0,
		columns = { },
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
			gridlist[ i ] = f;
		end
	end

	if type( content ) ~= "table" then
		relative, parent = content, relative;
	end
	
	gridlist.gui = guiCreateGridList( x, y, width, height, ( type( relative ) == "boolean" ) and relative or false, parent );
	if( gridlist.gui ) then
		setmetatable( gridlist, self );
		self.__index = self;
		
		if type( content ) == "table" then -- if we create a gridlist with table then...
			for i, j in ipairs( content ) do
				if i == 1 then -- this is columns table
					for k, l in ipairs( j ) do
						gridlist:AddColumn( unpack( l ) );
					end
				elseif i == 2 then -- and this is rows table
					for k, l in ipairs( j ) do
						gridlist:AddRow( unpack( l ) );
					end
				end
			end
		end
		
		addEventHandler( "onClientMouseEnter", gridlist.gui, function( ) GUICollection.guiMouseIsOver = gridlist;  end, false );
		addEventHandler( "onClientMouseLeave", gridlist.gui, function( ) GUICollection.guiMouseIsOver = false;  end, false );
		addEventHandler( "onClientGUIClick", 
			gridlist.gui,
			function( mouseBtn, state, x, y )
				if type( gridlist.onclick ) == "table" then
					for i, f in pairs( gridlist.onclick ) do
						f( gridlist, mouseBtn, state, x, y );
					end
				end
			end, 
			false
		);
		addEventHandler( "onClientMouseEnter", 
			gridlist.gui,
			function( x, y )
				if type( gridlist.onmouseenter ) == "table" then
					for _, f in pairs( gridlist.onmouseenter ) do
						if type( f ) == "function" then
							f( gridlist, x, y );
						end
					end
				end
			end, 
			false
		)
		addEventHandler( "onClientMouseLeave", 
			gridlist.gui,
			function( x, y )
				if type( gridlist.onmouseleave ) == "table" then
					for _, f in pairs( gridlist.onmouseleave ) do
						if type( f ) == "function" then
							f( gridlist, x, y );
						end
					end
				end
			end, 
			false
		)

		return gridlist;
	end
	return false
end

--	Function: GridList:AutoSizeColumn
--	Autosizes specified column
--	
--	Required Arguments:
--	   columnID - (integer) Integer of the column to size
--	   
--	Returns:
--		The result is true if autosized, false if not
function GridList:AutoSizeColumn( columnID )
	if ( type( self ) ~= "table" ) then
		outputDebugString( "calling method incorrectly ( object.method() )! use object:method()", 1 );
		return false
	end
	if ( type( columnID ) == "number" ) then
		return guiGridListAutoSizeColumn( self.gui, columnID );
	end
	return false;
end

--	Function: GridList:AddColumn
--	Adds a column
--	
--	Required Arguments:
--	   title - (string) Title of the column to add
--   
--  Optional Arguments:
--	   width - (integer) The width of the column to add
--	   
--	Returns:
--		The result is true if added, false if not
function GridList:AddColumn( title, width )
	if ( type( self ) ~= "table" ) then
		outputDebugString( "calling method incorrectly ( object.method() )! use object:method()", 1 );
		return false
	end
	if ( type( title ) == "string" ) and ( type( width ) == "number" ) then
		local temp = guiGridListAddColumn( self.gui, title, width );
		if temp then
			table.insert( self.columns, temp );
			return temp;
		end
	end
	return false;
end

--	Function: GridList:AddRow
--	Adds a row
--	
--	Required Arguments:
--	   ... - (strings) Values in the row
--	   
--	Returns:
--		The result is true if added, false if not
function GridList:AddRow( ... )
	if ( type( self ) ~= "table" ) then
		outputDebugString( "calling method incorrectly ( object.method() )! use object:method()", 1 );
		return false;
	end
	local temp = guiGridListAddRow( self.gui );
	if temp then
		if ( ( #arg > 0 ) and ( #arg <= self:ColumnCount() ) ) then
			for i, txt in ipairs( arg ) do
				guiGridListSetItemText( self.gui, temp, i, txt, false, false );
			end
			return temp;
		end
	end
	return false;
end

--	Function: GridList:Clear
--	Clears the gridlist
--	   
--	Returns:
--		The result is true if cleared, false if not
function GridList:Clear( )
	if ( type( self ) ~= "table" ) then
		outputDebugString( "calling method incorrectly ( object.method() )! use object:method()", 1 );
		return false
	end
	
	self.columns = nil;
	self.columns = { };
	return guiGridListClear( self.gui );
end

--	Function: GridList:ClearRows
--	Clears the gridlist's rows
--	   
--	Returns:
--		The result is true if cleared, false if not
function GridList:ClearRows( )
	if ( type( self ) ~= "table" ) then
		outputDebugString( "calling method incorrectly ( object.method() )! use object:method()", 1 );
		return false
	end
	
	return guiGridListClear( self.gui );
end

--	Function: GridList:ItemData
--	Gets/sets data of an item
--	
--	Required Arguments:
--	   rowID - (integer) Number of the row
--     columnID - (integer) Number of the column
--
--  Optional Arguments:
--     data - (string) If set, the row data will be set to it
--	   
--	Returns:
--		* String if tried to get
--      * If tried to set, true if setted, false if not
function GridList:ItemData( rowID, columnID, data )
	if ( type( self ) ~= "table" ) then
		outputDebugString( "calling method incorrectly ( object.method() )! use object:method()", 1 );
		return false
	end
	if ( type( rowID ) == "number" ) and ( type( columnID ) == "number" ) then
		if ( type( data ) == "string" ) then
			return guiGridListSetItemData( self.gui, rowID, columnID, data );
		else
			return guiGridListGetItemData( self.gui, rowID, columnID );
		end
	end
	return false
end

--	Function: GridList:ItemText
--	Gets/sets text of an gridlist row's item
--	
--	Required Arguments:
--	   rowID - (integer) Number of the row
--     columnID - (integer) Number of the column
--
--  Optional Arguments:
--     text - (string) If set, the value of a column in a row will be set to it.
--     section - (string) ?
--     number - (string) ?
--	   
--	Returns:
--		* String if tried to get
--      * If tried to set, true if setted, false if not
function GridList:ItemText( rowID, columnID, text, section, number )
	if ( type( self ) ~= "table" ) then
		outputDebugString( "calling method incorrectly ( object.method() )! use object:method()", 1 );
		return false
	end
	if ( type( rowID ) == "number" ) and ( type( columnID ) == "number" ) then
		if ( type( text ) == "string" ) then
			return guiGridListSetItemText( self.gui, rowID, columnID, text, 
								( type( section ) == "boolean" ) and section or false, 
								( type( number ) == "boolean" ) and number or false );
		else
			return guiGridListGetItemText( self.gui, rowID, columnID );
		end
	end
	return false;
end

--	Function: GridList:SelectedItem
--	Gets/sets selected item
--
--  Optional Arguments:
--     rowID - (integer) If set, the selected item will be set to it.
--     columnID - (integer) If set, the selected item will be set to it.
--	   
--	Returns:
--		* Position of selected item if tried to get
--      * If tried to set, true if setted, false if not
function GridList:SelectedItem( rowID, columnID )
	if ( type( self ) ~= "table" ) then
		outputDebugString( "calling method incorrectly ( object.method() )! use object:method()", 1 );
		return false
	end
	if ( type( rowID ) == "number" ) and ( type( columnID ) == "number" ) then
		return guiGridListSetSelectedItem( self.gui, rowID, columnID )
	end
	return guiGridListGetSelectedItem( self.gui );
end

--	Function: GridList:SortingEnabled
--	Gets/sets is sorting enabled
--
--  Optional Arguments:
--     enabled - (bool) If set, the sorting state will be set to it.
--	   
--	Returns:
--		* State of sorting if tried to get
--      * If tried to set, true if setted, false if not
function GridList:SortingEnabled( enabled )
	if ( type( self ) ~= "table" ) then
		outputDebugString( "calling method incorrectly ( object.method() )! use object:method()", 1 );
		return false
	end
	if ( type( enabled ) == "boolean" ) then
		if( guiGridListSetSortingEnabled( self.gui, enabled ) ) then
			self.sorting = enabled;
			return true
		end
	end
	return self.sorting;
end

--	Function: GridList:RowCount
--	Returns the count of rows
--	   
--	Returns:
--		Returns the count of rows
function GridList:RowCount( )
	if ( type( self ) ~= "table" ) then
		outputDebugString( "calling method incorrectly ( object.method() )! use object:method()", 1 );
		return false
	end
	return guiGridListGetRowCount( self.gui );
end

--	Function: GridList:ColumnCount
--	Returns the count of columns
--	   
--	Returns:
--		Returns the count of columns
function GridList:ColumnCount( )
	if ( type( self ) ~= "table" ) then
		outputDebugString( "calling method incorrectly ( object.method() )! use object:method()", 1 );
		return false
	end
	local count = 0;
	for _ in pairs( self.columns ) do
		count = count + 1;
	end
	return count;
end

--	Function: GridList:InsertRowAfter
--	Inserts a row after specified row id
--
--  Required Arguments:
--		rowID - (integer) The ID of row to add after
--	   
--	Returns:
--		Returns true if added, false if not
function GridList:InsertRowAfter( rowID )
	if ( type( self ) ~= "table" ) then
		outputDebugString( "calling method incorrectly ( object.method() )! use object:method()", 1 );
		return false
	end
	if ( type( rowID ) == "number" ) then
		return guiGridListInsertRowAfter( self.gui, rowID );
	end
	return false;
end

--	Function: GridList:RemoveColumn
--	Removes column with specified id
--
--  Required Arguments:
--		columnID - (integer) The ID of column to remove
--	   
--	Returns:
--		Returns true if removed, false if not
function GridList:RemoveColumn( columnID )
	if ( type( self ) ~= "table" ) then
		outputDebugString( "calling method incorrectly ( object.method() )! use object:method()", 1 );
		return false
	end
	if ( type( columnID ) == "number" ) then
		for i, k in pairs( self.columns ) do
			if k == columnID then
				local temp = guiGridListRemoveColumn( self.gui, column );
				if temp then
					table.remove( self.columns, i );
					return true;
				end
			end
		end
		return false
	end
	return false
end

--	Function: GridList:RemoveRow
--	Removes row with specified id
--
--  Required Arguments:
--		rowID - (integer) The ID of row to remove
--	   
--	Returns:
--		Returns true if removed, false if not
function GridList:RemoveRow( rowID )
	if ( type( self ) ~= "table" ) then
		outputDebugString( "calling method incorrectly ( object.method() )! use object:method()", 1 );
		return false
	end
	if ( type( rowID ) == "number" ) then
		return guiGridListRemoveRow( self.gui, rowID );
	end
	return false
end

--	Function: GridList:ScrollBars
--	Gets/sets state of scrollbars
--
--  Required Arguments:
--		horizontal - (bool) Is horizontal scrollbar enabled?
--		vertical - (bool) Is vertical scrollbar enabled?
--	   
--	Returns:
--		Returns true if removed, false if not
function GridList:ScrollBars( horizontal, vertical )
	if ( type( self ) ~= "table" ) then
		outputDebugString( "calling method incorrectly ( object.method() )! use object:method()", 1 );
		return false
	end
	if ( type( horizontal ) == "boolean" ) and ( type( vertical ) == "boolean" ) then
		if guiGridListSetScrollBars( self.gui, horizontal, vertical ) then
			self.horizontalBar = horizontal;
			self.verticalBar = vertical;
			return true;
		end
	end
	return self.horizontalBar, self.verticalBar;
end

--	Function: GridList:SelectionMode
--	Gets/sets the selection mode
--
--  Required Arguments:
--		mode - (integer) ID of selection mode
--	   
--	Returns:
--		* Returns state if tried to get
--      * Returns true or false if tried to set
function GridList:SelectionMode( mode )
	if ( type( self ) ~= "table" ) then
		outputDebugString( "calling method incorrectly ( object.method() )! use object:method()", 1 );
		return false
	end
	if ( type( mode ) == "number" ) then
		return guiGridListSetSelectionMode( self.gui, mode );
	end
	return self.selectiomode;
end

--	Function: GridList:ItemColor
--	Gets/sets the color item
--
--  Required Arguments:
--		rowIndex - (integer) ID of row
--		columnIndex - (integer) ID of column   

--  Optional Arguments:
--		If set, the color item will be set to it.
--     	red - (integer) ?
--     	green - (integer) ?
--     	blue - (integer) ?
--		alpha - (integer) ?

--	Returns:
--		* Returns color if tried to get
--      * Returns true or false if tried to set
function GridList:ItemColor(  rowIndex, columnIndex, red, green, blue, alpha )
	if ( type( self ) ~= "table" ) then
		outputDebugString( "calling method incorrectly ( object.method() )! use object:method()", 1 );
		return false
	end
	TableAssert
	{
		{
			value 		= type( rowIndex );
			condition 	= 'number';
			sMsg 		= '1 argument not is number';
		};
		{
			value 		= type( columnIndex );
			condition 	= 'number';
			sMsg 		= '2 argument not is number';
		};
	};
return guiGridListGetItemColor( self.gui, rowIndex, columnIndex, tonumber(red) or 255, tonumber(green) or 255, tonumber(blue) or 255, tonumber(alpha) or 255 );
end
]])
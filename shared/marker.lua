--[[
		Marker class written by Kenix
		Additional 
		Version:        1.0.0
]]


push([[

Marker = Class:Create( )

function Marker:toObj( ele )
	if ele then
		local obj = Class:Create( Marker )
		obj.ele = ele
		return obj
	end
	return false
end

function Marker:Create( nX, nY, nZ, sType, nSize, nR, nG, nB, nA, uVisible )
	TableAssert 
	{
		{
			value 			= type( nX );
			condition 		= 'number';
			sMsg  			= '1 argument is not number';
		
		};
		{
			value 			= type( nY );
			condition		= 'number';
			sMsg  			= '2 argument is not number';
		};
		{
			value 			= type( nZ );
			condition 		= 'number';
			sMsg  			= '3 argument is not number';
		};
	}
	if type( sType ) == 'string' then
		TableAssert 
		{
			{
				value 			= type( nSize );
				condition 		= 'number';
				sMsg  			= '4 argument is not number';
			
			};
			{
				value 			= type( nR );
				condition		= 'number';
				sMsg  			= '5 argument is not number';
			};
			{
				value 			= type( nG );
				condition 		= 'number';
				sMsg  			= '6 argument is not number';
			};
			{
				value 			= type( nB );
				condition 		= 'number';
				sMsg  			= '7 argument is not number';
			};
			{
				value 			= type( nA );
				condition 		= 'number';
				sMsg  			= '8 argument is not number';
			};
		}
	end
	local ele = createMarker( nX, nY, nZ, sType, nSize, nR, nG, nB, nA, uVisible or root )
	return Marker:toObj( ele )
end

function Marker:Destroy( )
	return destroyElement( self.ele )
end

function Marker:Color( )
	return getMarkerColor( self.ele )
end

function Marker:Icon( )
	return getMarkerIcon( self.ele )
end

function Marker:Size( )
	return getMarkerSize( self.ele )
end

function Marker:Target( )
	return getMarkerTarget( self.ele )
end

function Marker:Type( )
	return getMarkerType( self.ele )
end

function Marker:IsElementIn( uElement )
	assert( isElement( uElement ), '1 argument is not element.' )
	return isElementWithinMarker( uElement, self.ele )
end

function Marker:SetColor( nR, nG, nB, nA )
	TableAssert
	{
		{
			value 			= type( nR );
			condition		= 'number';
			sMsg  			= '1 argument is not number';
		};
		{
			value 			= type( nG );
			condition 		= 'number';
			sMsg  			= '2 argument is not number';
		};
		{
			value 			= type( nB );
			condition 		= 'number';
			sMsg  			= '3 argument is not number';
		};
		{
			value 			= type( nA );
			condition 		= 'number';
			sMsg  			= '4 argument is not number';
		};
	}
	return setMarkerColor( self.ele, nR, nG, nB, nA )
end

function Marker:SetIcon( sName )
	assert( type( sName ) == 'string', '1 argument is not string' )
	assert( sName == 'none' or sName == 'arrow' or sName == 'finish', '1 argument is not ( \'type\' or \'arrow\' or \'finish\' )' )
	return setMarkerIcon( self.ele, sName )
end

function Marker:SetSize( nSize )
	assert( type( nSize ) == 'number', '1 argument is not number' )
	return setMarkerSize( self.ele, nSize )
end

function Marker:SetTarget( nX, nY, nZ )
	TableAssert
	{
		{
			value 			= type( nX );
			condition		= 'number';
			sMsg  			= '1 argument is not number';
		};
		{
			value 			= type( nY );
			condition 		= 'number';
			sMsg  			= '2 argument is not number';
		};
		{
			value 			= type( nZ );
			condition 		= 'number';
			sMsg  			= '3 argument is not number';
		};
	}
	return setMarkerTarget( self.ele, nX, nY, nZ )
end

function Marker:SetType( sType )
	assert( type( sType ) == 'string', '1 argument is not string' )
	assert( 
		sType == 'checkpoint' or 
		sType == 'ring' or 
		sType == 'cylinder' or
		sType == 'arrow' or
		sType == 'corona', 
		'1 argument is not ( \'checkpoint\' or \'ring\' or \'cylinder\' or \'arrow\' or \'corona\')' 
	)
	return setMarkerType( self.ele, sType )
end
]])
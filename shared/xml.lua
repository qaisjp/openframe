--[[
        XML class written by Kenix
        Additional 
        Version:        1.0.0
]]


push([[

XML = Class:Create()

function XML:toObj( ele )
	if ele then
		local obj = Class:Create( XML )
		obj.ele = ele
		return obj
	end
	return false
end

function XML:Create( sPath, sNodeName )
	TableAssert
	{
		{
			value 		= type( sPath );
			condition 	= 'string';
			sMsg		= '1 argument is not string';
		};
		{
			value 		= type( sNodeName );
			condition 	= 'string';
			sMsg		= '2 argument is not string';
		};
	}
	local ele = xmlCreateFile( sPath, sNodeName )
	return XML:toObj( ele )
end

function XML:Copy( sPath )
	assert( type( sPath ) == 'string', '1 argument is not string' )
	local ele = xmlCopyFile( self.ele, sPath )
	return XML:toObj( ele )
end

function XML:Load( sPath )
	assert( type( sPath ) == 'string', '1 argument is not string' )
	local ele = xmlLoadFile( sPath )
	return XML:toObj( ele ) 
end

function XML:DestroyNode( )
	return xmlDestroyNode( self.ele )
end

function XML:Attribute( sName, Value )
	assert( type( sName ) == 'string', '1 argument is not string' )
	if type( Value ) == 'string' or type( Value ) == 'number' then
		return xmlNodeSetAttribute( self.ele, sName, Value )
	end
	return xmlNodeGetAttribute( self.ele, sName )
end

function XML:Value( sValue )
	if type( sValue ) == 'string' then
		return xmlNodeSetValue( self.ele, sValue )
	end
	return xmlNodeGetValue( self.ele )
end

function XML:Save( )
	return xmlSaveFile( self.ele )
end

function XML:Unload( )
	return xmlUnloadFile( self.ele )
end

function XML:CreateChild( sTag )
	assert( type( sTag ) == 'string', '1 argument is not string' )
	return xmlCreateChild( self.ele, sTag )
end

function XML:FindChild( sTag, nIndex )
	TableAssert
	{
		{
			value 		= type( sTag );
			condition 	= 'string';
			sMsg		= '1 argument is not string';
		};
		{
			value 		= type( nIndex );
			condition 	= 'number';
			sMsg		= '2 argument is not number';
		};
	}
	return xmlFindChild( self.ele, sTag, nIndex )
end

function XML:Attributes( )
	return xmlNodeGetAttributes( self.ele )
end

function XML:Children( nIndex )
	return xmlNodeGetChildren( self.ele, nIndex )
end

function XML:Name( sName )
	if type( sName ) == 'string' then
		return xmlNodeSetName( self.ele, sName )
	end
	return xmlNodeGetName( self.ele )
end

function XML:Parent( )
	return xmlNodeGetParent( self.ele )
end
]])
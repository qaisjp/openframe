--[[
	Sound class written by Kenix
	Additional 
	Version:     	1.0.0
]]
push([[

Sound = Class:Create()
	
function fTableAssert( t )
	if type( t ) == 'table' then
		for _, v in pairs( t ) do
			if v.value and v.condition then
				assert( v.value == v.condition, v.sMsg )
			elseif v.condition == false then
				assert( v.condition, v.sMsg )
			end
		end
		return true
	end
	return false
end

function Sound:toObj( ele )
	if ele then
		local obj = Class:Create(Sound)
		obj.ele = ele
		return obj
	end
	return false
end

function Sound:Play3D( sPath, nX, nY, nZ, bLoop )
	fTableAssert 
	{ 
		{
			value 		= type( sPath );
			condition 	= 'string';
			sMsg 		= '1 argument is not string';
		};
		{
			value 		= type( nX );
			condition 	= 'number';
			sMsg 		= '2 argument is not number';
		};
		{
			value 		= type( nY );
			condition 	= 'number';
			sMsg 		= '3 argument is not number';
		};
		{
			value 		= type( nZ );
			condition 	= 'number';
			sMsg 		= '4 argument is not number';
		};
	}
	
	local ele = playSound3D( sPath, nX, nY, nZ, bLoop )
	return Sound:toObj(ele)
end

function Sound:Play( sPath, bLoop )
	fTableAssert 
	{ 
		{
			value 		= type( sPath );
			condition 	= 'string';
			sMsg 		= '1 argument is not string';
		}
	}
	local ele = playSound( sPath, bLoop )
	return Sound:toObj(ele)
end

function Sound:Volume( nVolume )
	if nVolume then
		fTableAssert 
		{ 
			{
				value 		= type( nVolume );
				condition 	= 'number';
				sMsg 		= '1 argument is not number';
			};
			{
				condition	= nVolume >= 0 and nVolume <= 1; 
				sMsg		= 'Incorrect volume number';
			};
		}
		return setSoundVolume( self.ele, nVolume )
	end
	
	return getSoundVolume ( self.ele )
end

function Sound:Speed( nSpeed )
	if nSpeed then
		fTableAssert 
		{ 
			{
				value 		= type( nSpeed );
				condition 	= 'number';
				sMsg 		= '1 argument is not number';
			};
		}
		return setSoundSpeed( self.ele, nSpeed )
	end
	
	return getSoundSpeed( self.ele )
end

function Sound:Position( nPos )
	if nPos then
		fTableAssert 
		{ 
			{
				value 		= type( nPos );
				condition 	= 'number';
				sMsg 		= '1 argument is not number';
			};
		}
		return setSoundPosition( self.ele, nPos )
	end
	
	return getSoundPosition( self.ele )
end


function Sound:Pause( bState )
	if bState then
		fTableAssert 
		{ 
			{
				value 		= type( bState );
				condition 	= 'boolean';
				sMsg 		= '1 argument is not boolean';
			};
		}
		return setSoundPaused( self.ele, bState )
	end
	
	return isSoundPaused( self.ele )
end

function Sound:MaxDistance( nDistance )
	if nDistance then
		fTableAssert 
		{ 
			{
				value 		= type( nDistance );
				condition 	= 'number';
				sMsg 		= '1 argument is not number';
			};
		}
		return setSoundMaxDistance( self.ele, nDistance )
	end
	
	return getSoundMaxDistance( self.ele )
end


function Sound:MinDistance( nDistance )
	if nDistance then
		fTableAssert 
		{ 
			{
				value 		= type( nDistance );
				condition 	= 'number';
				sMsg 		= '1 argument is not number';
			};
		}
		return setSoundMinDistance( self.ele, nDistance )
	end
	
	return getSoundMinDistance( self.ele )
end

function Sound:Effect( sName, bEnable )
	fTableAssert 
	{ 
		{
			value 		= type( sName );
			condition 	= 'string';
			sMsg 		= '1 argument is not string';
		};
		{
			value 		= type( bEnable );
			condition 	= 'boolean';
			sMsg 		= '1 argument is not boolean';
		};
	}
	
	return setSoundEffectEnabled( self.ele, sName, bEnable )
end

function Sound:Stop( )
	return stopSound( self.ele )
end

function Sound:Destroy( )
	return destroyElement( self.ele )
end

function Sound:MetaTags( )
	return getSoundMetaTags( self.ele )
end

function Sound:Length( )
	return getSoundLength( self.ele )
end
]])
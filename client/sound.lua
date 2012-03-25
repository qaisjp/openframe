--[[
	Sound class writed by Kenix
	Version:     	1.0.0
]]

Sound = { }

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
	local uSound = playSound3D( sPath, nX, nY, nZ, bLoop )
	assert( isElement( uSound ), 'playSound3D' )
	return setmetatable( { uSound = uSound }, { __index = Sound } )
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
	local uSound = playSound( sPath, bLoop )
	assert( isElement( uSound ), 'playSound' )
	return setmetatable( { uSound = uSound }, { __index = Sound } )
end

function Sound:Volume( nVolume )
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
	return setSoundVolume( self.uSound, nVolume )
end

function Sound:Speed( nSpeed )
	fTableAssert 
	{ 
		{
			value 		= type( nSpeed );
			condition 	= 'number';
			sMsg 		= '1 argument is not number';
		};
	}
	return setSoundSpeed( self.uSound, nSpeed )
end

function Sound:Position( nPos )
	fTableAssert 
	{ 
		{
			value 		= type( nPos );
			condition 	= 'number';
			sMsg 		= '1 argument is not number';
		};
	}
	return setSoundPosition( self.uSound, nPos )
end

function Sound:Pause( bState )
	fTableAssert 
	{ 
		{
			value 		= type( bState );
			condition 	= 'boolean';
			sMsg 		= '1 argument is not boolean';
		};
	}
	return setSoundPaused( self.uSound, bState )
end

function Sound:MaxDistance( nDistance )
	fTableAssert 
	{ 
		{
			value 		= type( nDistance );
			condition 	= 'number';
			sMsg 		= '1 argument is not number';
		};
	}
	return setSoundMaxDistance( self.uSound, nDistance )
end

function Sound:MinDistance( nDistance )
	fTableAssert 
	{ 
		{
			value 		= type( nDistance );
			condition 	= 'number';
			sMsg 		= '1 argument is not number';
		};
	}
	return setSoundMinDistance( self.uSound, nDistance )
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
	return setSoundEffectEnabled( self.uSound, sName, bEnable )
end

function Sound:Stop( )
	return stopSound( self.uSound )
end

function Sound:Destroy( )
	return destroyElement( self.uSound )
end

function Sound:IsPaused( )
	return isSoundPaused( self.uSound )
end

function Sound:GetVolume( )
	return getSoundVolume( self.uSound )
end

function Sound:getSpeed( )
	return getSoundSpeed( self.uSound )
end

function Sound:getPosition( )
	return getSoundPosition( self.uSound )
end

function Sound:getMinDistance( )
	return getSoundMinDistance( self.uSound )
end

function Sound:getMaxDistance( )
	return getSoundMaxDistance( self.uSound )
end

function Sound:getMetaTags( )
	return getSoundMetaTags( self.uSound )
end

function Sound:getLength( )
	return getSoundLength( self.uSound )
end

function Sound:getEffects( )
	return getSoundEffects( self.uSound )
end



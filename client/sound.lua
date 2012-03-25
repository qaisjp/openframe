--[[
	Sound class writed by Kenix
	Version:     	1.0.0
]]

CSound = { }

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

function CSound:Play3D( sPath, nX, nY, nZ, bLoop, bInsert )
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
	if not bInsert then
		return setmetatable( { uSound = uSound }, { __index = CSound } )
	end
	return uSound
end

function CSound:Play( sPath, bLoop, bInsert )
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
	if not bInsert then
		return setmetatable( { uSound = uSound }, { __index = CSound } )
	end
	return uSound
end

function CSound:Volume( nVolume )
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

function CSound:Speed( nSpeed )
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

function CSound:Position( nPos )
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

function CSound:Pause( bState )
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

function CSound:MaxDistance( nDistance )
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

function CSound:MinDistance( nDistance )
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

function CSound:Effect( sName, bEnable )
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

function CSound:Stop( )
	return stopSound( self.uSound )
end

function CSound:Destroy( )
	return destroyElement( self.uSound )
end

function CSound:IsPaused( )
	return isSoundPaused( self.uSound )
end

function CSound:GetVolume( )
	return getSoundVolume( self.uSound )
end

function CSound:getSpeed( )
	return getSoundSpeed( self.uSound )
end

function CSound:getPosition( )
	return getSoundPosition( self.uSound )
end

function CSound:getMinDistance( )
	return getSoundMinDistance( self.uSound )
end

function CSound:getMaxDistance( )
	return getSoundMaxDistance( self.uSound )
end

function CSound:getMetaTags( )
	return getSoundMetaTags( self.uSound )
end

function CSound:getLength( )
	return getSoundLength( self.uSound )
end

function CSound:getEffects( )
	return getSoundEffects( self.uSound )
end



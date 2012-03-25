--[[
        Timer class written by Kenix
        Additional 
        Version:        1.0.0
]]


push( [[

Timer = Class:Create()

function Timer:toObj( ele )
	if ele then
		local obj = Class:Create( Timer )
		obj.ele = ele
		return obj
	end
	return false
end

function Timer:Create( fCallBack, nInterval, nTimesToExecute, ... )
	TableAssert 
	{
		{
			value 			= type( fCallBack );
			condition       = 'function';
			sMsg            = '1 argument is not function';
		
		};
		{
			value 			= type( nInterval );
			condition       = 'number';
			sMsg            = '2 argument is not number';
		};
		{
			value 			= type( nTimesToExecute );
			condition       = 'number';
			sMsg            = '3 argument is not number';
		};
	}
	local ele = setTimer( fCallBack, nInterval, nTimesToExecute, ... )
	return Timer:toObj( ele )
end

function Timer:Kill( )
	return killTimer( self.ele )
end

function Timer:Reset( )
	return resetTimer( self.ele )
end

function Timer:Is( )
	return isTimer( self.ele )
end

function Timer:Details( )
	return getTimerDetails( self.ele )
end


]] )



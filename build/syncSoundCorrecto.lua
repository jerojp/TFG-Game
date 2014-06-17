function pauseSentence(button, channel )
	-- body
	transition.pause( )
	print( "CAMBIO-----------" )
	audio.pause( channel )
end

function reanudeSentence(button, channel )
	-- body
	transition.resume( )
	audio.resume( channel )
end
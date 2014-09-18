require( "ControlScene" )

kwkexp:pause( )
kwkesq:pause()

_G.Level = 3
_G.Phase = 2

local aud = {"exp_ps6.mp3", "exp_ps7.mp3"}
local sub = {"Así que ya hemos llegado, pero no consigo ver el barco.",
			"Vaya no entiendo esa ultima palabra. Ah, es un nuevo baile: el baile del iceberg."}

addCharacter(kwkexp, aud, sub)

aud = {"anori_4.mp3", "anori_5.mp3"}
sub = {"Está al lado de aquel iceberg.",
	 "No. El iceberg es un bloque de hielo en el mar."}

addCharacter(kwkesq, aud, sub)

local sec = {1, 2, 1, 2}
setSecuence( sec )

playScene( "page_15" )
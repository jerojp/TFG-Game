require( "ControlScene" )

kwkexp:pause( )
kwkafr:pause( )

_G.Level = 5
_G.Phase = 2

local aud = {"exp_afr9.mp3"}
local sub = {"Listo, ya están estos juguetes repartidos. Ahora hay que anotarlo también. A escribir la letra U en la caja."}
local sec = {1}

addCharacter(kwkexp, aud, sub)
setSecuence( sec )
playScene( "page_57" )
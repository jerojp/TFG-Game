require( "ControlScene" )
kwkexp:pause( )
kwkesq:pause()

_G.Level = 3
_G.Phase = 2

local aud = {"exp_ps10.mp3", "exp_ps11.mp3"}
local sub = {"Al fin hemos encontrado el tesoro. Muchas gracias Anori.",
			"Claro, vendré a visitarte algún día !Adiós!"}

addCharacter(kwkexp, aud, sub)

aud = {"esquimal_7.mp3"}
sub = {"De nada. Vuelve siempre que quieras."}

addCharacter(kwkesq, aud, sub)

local sec = {1, 2, 1}
setSecuence( sec )

playScene( "page_11" )
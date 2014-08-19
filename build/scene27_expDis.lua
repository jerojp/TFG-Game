require( "ControlScene" )
kwkexpf:pause( )

--timerStash.timer_PRUEBA = timer.performWithDelay( 5000, act_pr, 1 )
_G.Subtitle = false
_G.AutoNextPage = true

_G.Level = 1
_G.Phase = 1

local aud = {"exp_br4.mp3"}
local sub = {"!Ya estoy! Me he disfrazado de flamenco. Pero creo que me falta algo, la mujer de la tienda me dijo que cogiera un antifaz pero no he sabido qué es. A ver si consigo recordar que es un antifaz."}

addCharacter(kwkexpf, aud, sub)

local sec = {1}
setSecuence( sec )

playScene( "page_15" )
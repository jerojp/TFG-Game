require( "ControlScene" )

kwkexp:pause( )

--timerStash.timer_PRUEBA = timer.performWithDelay( 5000, act_pr, 1 )
--_G.Subtitle = false
--_G.AutoNextPage = true

_G.Level = 1
_G.Phase = 2

local aud = {"exp_br4.mp3"}
local sub = {"Vaya que tarde se me ha hecho. Debo ponerme rumbo al Amazonas. Espero no perderme en la selva más grande del mundo."}

addCharacter(kwkexp, aud, sub)

local sec = {1}
setSecuence( sec )

playScene( "page_33" )
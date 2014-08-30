require( "ControlScene" )

kwkexp:pause( )
kwkjap:pause( )

--timerStash.timer_PRUEBA = timer.performWithDelay( 5000, act_pr, 1 )
--_G.Subtitle = false
--_G.AutoNextPage = true

_G.Level = 4
_G.Phase = 1

local aud = {"exp_ja6.mp3"}
local sub = {"Ah, claro, un oso panda. Bueno, era parecido a lo que yo había dicho."}

addCharacter(kwkexp, aud, sub)

local sec = {1}
setSecuence( sec )

playScene( "page_47" )
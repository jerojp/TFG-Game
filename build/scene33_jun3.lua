require( "ControlScene" )

kwksamin:pause()

--timerStash.timer_PRUEBA = timer.performWithDelay( 5000, act_pr, 1 )
--_G.Subtitle = false
--_G.AutoNextPage = true

_G.Level = 1
_G.Phase = 2

local aud = {"samin_br3.mp3"}
local sub = {"Ah, se me olvidó decirte que debes escribir la letra A sobre la roca para activar la trampa."}

addCharacter(kwksamin, aud, sub)

local sec = {1}
setSecuence( sec )

playScene( "page_29" )
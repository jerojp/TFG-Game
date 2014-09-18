require( "ControlScene" )

kwkexp:pause( )
kwkexphumo:pause( )
kwkexphumo.alpha = 0

--timerStash.timer_PRUEBA = timer.performWithDelay( 5000, act_pr, 1 )
--_G.Subtitle = false
--_G.AutoNextPage = true

_G.Level = 4
_G.Phase = 1

local function changeAlpha( fun )
	-- body
	kwkexp.alpha = 0
	kwkexphumo.alpha = 1
	fun(300)
end

local aud = {"exp_ja1.mp3"}
local sub = {"!Qué lastima!, un oso panda ha sido secuestrado para venderlo. No puedo permitirlo hay que rescatarlo, los animales deben vivir en libertad."}

addCharacter(kwkexp, aud, sub)

local aud2 = {"exp_ja2.mp3"}
local sub2 = {"!No! La tablet se ha roto. Espero que el Ali esté bien. Debo viajar rápido a Japón para poder arreglarla."}

addCharacter(kwkexphumo, aud2, sub2)

local sec = {1, 2}
setSecuence( sec )

local events = { {mytype = "effects", value = {1, changeAlpha} }, nil }
setEventsControlScene(events)

playScene( "page_45" )
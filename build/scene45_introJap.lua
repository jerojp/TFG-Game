require( "ControlScene" )

kwkexp:pause( )
kwkjap:pause( )

--timerStash.timer_PRUEBA = timer.performWithDelay( 5000, act_pr, 1 )
--_G.Subtitle = false
--_G.AutoNextPage = true

_G.Level = 4
_G.Phase = 1

local function changeAlpha( fun )
	-- body
	kwktablet:pause( )
	kwktablet.alpha = 0
	fun(300)
end

local aud = {"exp_ja3.mp3", "exp_ja4.mp3", "exp_ja5.mp3"}
local sub = {"!Hola! Sakura, me alegro de verte.",
			"¿Puedes ayudarme a reparar mi tablet?",
			"Claro, en marcha. La caza de animales debería estar prohibida. Pero antes de salir quiero asegurarme. ¿Un oso panda es es esto? Nunca he visto uno."}

addCharacter(kwkexp, aud, sub)

local aud2 = {"sakura_ja1.mp3", "sakura_ja2.mp3", "sakura_ja3.mp3"}
local sub2 = {"Hola, yo también me alegro.",
			 "Ya está arreglada. Ahora necesito tu ayuda para rescatar al oso panda secuestrado por unos cazadores furtivos.",
			 "No eso es un koala. Un oso panda es un oso de color blanco y negro. Su nombre empieza por la letra O."}

addCharacter(kwkjap, aud2, sub2)

local sec = {1, 2, 1, 2, 1, 2}
setSecuence( sec )

local events = { nil, nil, {mytype = "effects", value = {1, changeAlpha} }, nil, nil, nil }
setEventsControlScene(events)

playScene( "page_15" )
require( "ControlScene" )

kwkboss:pause( )


--timerStash.timer_PRUEBA = timer.performWithDelay( 5000, act_pr, 1 )
--_G.Subtitle = false
--_G.AutoNextPage = true

_G.Level = 1
_G.Phase = 1

local aud = {"jefe_br1.mp3"}
local sub = {"Hola, te he llamado porque me acaban de dar un mapa de un tesoro y quiero que tú intentes encontrarlo. El mapa tiene una marca en forma de cruz sobre la región del río Amazonas en Brasil."}

addCharacter(kwkboss, aud, sub)

aud = {"exp_br1.mp3"}
sub = {"Vale jefe, pongo rumbo a brasil ahora mismo."}

addCharacter(nil, aud, sub)

local sec = {1, 2 }
setSecuence( sec )

local img = {path = imgDir.."mapAntiguo.png", w = 531, h = 707}
local events = { {mytype = "image", value = {1,  img} }, nil }
setEventsControlScene(events)

playScene( "page_26" )
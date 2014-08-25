require( "ControlScene" )
require("viewGenius")


--timerStash.timer_PRUEBA = timer.performWithDelay( 5000, act_pr, 1 )
--_G.Subtitle = false
--_G.AutoNextPage = true

local gpGenius = createGenius( )
gpGenius:scale( 0.3, 0.3 )
gpGenius:translate( display.contentWidth - (gpGenius.Tablet.contentWidth*1.85) , display.contentHeight - (gpGenius.Tablet.contentHeight *1.10) )
gpGenius.alpha = 0

_G.Level = 4
_G.Phase = 1

local aud = {"exp_ja9.mp3"}
local sub = {"Pues entonces rumbo a China."}

addCharacter(nil, aud, sub)

aud = {"genio_ja2.mp3"}
sub = {"Los osos panda viven en la selva de China."}

addCharacter(gpGenius.genius, aud, sub, gpGenius)

local sec = {2, 1}
setSecuence( sec )

local parameters = {nameToy="Oveja", pathToy="oveja.png", costToy=_G.PriceToys.sheep, widthToy = 233*1.5 , heightToy = 168*1.5, indexToy = 7}

playScene( "viewNewToy", parameters )
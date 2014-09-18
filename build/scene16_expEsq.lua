require( "ControlScene" )
require("viewGenius")

explSkier:pause( )

local gpGenius = createGenius( )
gpGenius:scale( 0.3, 0.3 )
gpGenius:translate( display.contentWidth - (gpGenius.Tablet.contentWidth*1.85) , display.contentHeight - (gpGenius.Tablet.contentHeight *1.10) )
gpGenius.alpha = 0
menuGroup:insert( gpGenius )
gpGenius.genius:pause( )

_G.Level = 2
_G.Phase = 1

local aud = {"exp_sz5.mp3"}
local sub = {"A ver si recuerdo cómo se llega a la casa de Eli. Pero antes debería parar en un pueblo cercano a su casa para realizar algunas compras."}

addCharacter(explSkier, aud, sub)

local aud = {"genio_eGPS.mp3"}
local sub = {"No te preocupes escribe la letra E para activar el gps de tu tablet, así no te perderás."}

addCharacter(gpGenius.genius, aud, sub)

local sec = {1, 2}
setSecuence( sec )

playScene( "page_17" )
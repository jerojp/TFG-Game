require( "ControlScene" )
require("viewGenius")

kwkexp:pause( )
kwkesq:pause()

local gpGenius = createGenius( )
gpGenius:scale( 0.3, 0.3 )
gpGenius:translate( display.contentWidth - (gpGenius.Tablet.contentWidth*1.85) , display.contentHeight - (gpGenius.Tablet.contentHeight *1.10) )
gpGenius.alpha = 0
menuGroup:insert( gpGenius )
gpGenius.genius:pause( )

_G.Level = 3
_G.Phase = 1

local aud = {"exp_ps5.mp3"}
local sub = {"!Ah! Eso es un iglú, qué casa más curiosa. Ali, tú sabías ¿qué es un iglú?."}

addCharacter(kwkexp, aud, sub)

aud = {"genio_ps1.mp3"}
sub = {"¿Un qué? No sé qué es eso. Escribe la letra I en la tablet a ver que puedo encontrar en Internet."}

addCharacter(gpGenius.genius, aud, sub, gpGenius)

local sec = {1, 2}
setSecuence( sec )

playScene( "page_38" )
require( "ControlScene" )
kwkexp:pause( )
kwkesq:pause()

local gpGenius = createGenius( )
gpGenius:scale( 0.3, 0.3 )
gpGenius:translate( display.contentWidth - (gpGenius.Tablet.contentWidth*1.85) , display.contentHeight - (gpGenius.Tablet.contentHeight *1.10) )
gpGenius.alpha = 0

_G.Level = 3
_G.Phase = 1

local aud = {"exp_ps5.mp3"}
local sub = {"Ya. Eso es un iglú, qué casa más curiosa. Ali, tú sabias ¿qué es un iglú?."}

addCharacter(kwkexp, aud, sub)

aud = {"genio_ps1.mp3"}
sub = {"¿Un qué? No sé qué es eso. Escríbelo en la tablet a ver que puedo encontrar en Internet."}

addCharacter(gpGenius.genius, aud, sub, nil, gpGenius)

local sec = {1, 2}
setSecuence( sec )

playScene( "page_38" )
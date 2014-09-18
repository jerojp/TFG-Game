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
_G.Phase = 2

local aud = {"exp_ps8.mp3", "exp_ps9.mp3"}
local sub = {"!Qué pasada!. Pero no veo el iceberg, debe ser pequeño.",
			"¿Y cómo vamos a llegar hasta allí?"}

addCharacter(kwkexp, aud, sub)

aud = {"anori_6.mp3"}
sub = {"No, es enorme, y lo tienes enfrente."}

addCharacter(kwkesq, aud, sub)

local aud = {"genio_iVolar.mp3"}
local sub = {"Trázame el camino para llegar al barco y yo mismo iré volando a por él. Escribe la letra I en la tablet para que pueda volar."}

addCharacter(gpGenius.genius, aud, sub)

local sec = {1, 2, 1, 3}
setSecuence( sec )

playScene( "page_38" )
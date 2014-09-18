require( "ControlScene" )
require("viewGenius")

kwkexp:pause( )

local gpGenius = createGenius( )
gpGenius:scale( 0.3, 0.3 )
gpGenius:translate( display.contentWidth - (gpGenius.Tablet.contentWidth*1.85) , display.contentHeight - (gpGenius.Tablet.contentHeight *1.10) )
gpGenius.alpha = 0
menuGroup:insert( gpGenius )
gpGenius.genius:pause( )

_G.Level = 4
_G.Phase = 2

local aud = {"exp_ja19.mp3"}
local sub = {"Estoy muy agusto aquí, pero es hora de irse. Voy a tomar una foto antes de irnos a los osos panda."}

addCharacter(kwkexp, aud, sub)

local aud = {"genio_oFoto.mp3"}
local sub = {"Escribe la letra O para poder tomar la foto."}

addCharacter(gpGenius.genius, aud, sub)

local sec = {1, 2}
setSecuence( sec )

playScene( "page_49" )
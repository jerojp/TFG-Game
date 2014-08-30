require( "ControlScene" )
require("viewGenius")

kwkexp:pause( )
kwkesq:pause()

local gpGenius = createGenius( )
gpGenius:scale( 0.3, 0.3 )
gpGenius:translate( display.contentWidth - (gpGenius.Tablet.contentWidth*1.85) , display.contentHeight - (gpGenius.Tablet.contentHeight *1.10) )
gpGenius.alpha = 1

_G.Level = 3
_G.Phase = 1

local aud = {"esquimal_3.mp3"}
local sub = {"Si ahí es donde vivimos los esquimales. Bueno acompañarme a mi casa y mañana iremos al barco hundido."}

addCharacter(kwkesq, aud, sub)

aud = {"genio_ps2.mp3"}
sub = {"¡Ah! Un iglú es como una casa pero hecha de hielo que se utiliza para protegerse del frío."}

addCharacter(gpGenius.genius, aud, sub, gpGenius)

local sec = {2, 1}
setSecuence( sec )

local parameters = {nameToy="Indio", pathToy="indio.png", costToy=_G.PriceToys.indian, widthToy = 233*1.5 , heightToy = 168*1.5, nextPage = "page_40", indexToy = 5}

playScene( "viewNewToy", parameters )
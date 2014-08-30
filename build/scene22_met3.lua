require( "ControlScene" )
require("viewGenius")

local gpGenius = createGenius( )
gpGenius:scale( 0.3, 0.3 )
gpGenius:translate( display.contentWidth - (gpGenius.Tablet.contentWidth*1.85) , display.contentHeight - (gpGenius.Tablet.contentHeight *1.10) )
gpGenius.alpha = 0

menuGroup:insert( gpGenius )
gpGenius.genius:pause( )


nurse:pause( )
explorer:pause()


local aud = {"eli_6.mp3", "eli_7.mp3"}
local sub = {"La encontré cuando caminaba por la montaña, un viejo sabio del pueblo me ha dicho que tiene un poder grandioso.",
			"El viejo sabio me dijo que el tenía la caja pero solo se la daría a la persona que consiguiera el pergamino de oro."}

addCharacter(nurse, aud, sub)

aud = {"exp_sz7.mp3", "exp_sz8.mp3"}
sub = {"!Vaya! !Qué piedra más bonita!",
	  "!Genial! Entonce conseguiré ese pergamino."}

addCharacter(explorer, aud, sub)

aud = {"genio_sz1.mp3", "genio_sz2.mp3"}
sub = {"Parece que no miente, esta piedra está ligada a una caja que custodia las puertas de una tierra desconocida. Si conseguimos la caja podremos averiguar qué tierra es.",
	  "!Has oído eso! Como recordarás yo te dije al iniciar la aventura que si conseguías completar todos los trabajos del jefe te entregaría el pergamino de oro."}

addCharacter(gpGenius.genius, aud, sub, gpGenius)

local sec = {2, 1, 3, 1, 3, 2 }
setSecuence( sec )

local parameters = {nameToy="Bicicleta", pathToy="objeto321.png", costToy=_G.PriceToys.bicycle, widthToy = 233*1.5 , heightToy = 168*1.5, nextPage = "page_11", indexToy = 4}

playScene( "viewNewToy", parameters )
require( "ControlScene" )

kwkexp:pause( )
kwkafr:pause( )

_G.Level = 5
_G.Phase = 1

local aud = {"exp_afr5.mp3", "exp_afr6.mp3"}
local sub = {"Ya está toda la comida repartida.",
			"No ha sido nada y parece que ya ha llegado el cargamento de juguetes, vamos a ayudarles."}

addCharacter(kwkexp, aud, sub)

aud = {"sira_3.mp3"}
sub = {"Muchas gracias por la ayuda."}
addCharacter(kwkafr, aud, sub)

local sec = {1, 2, 1}

setSecuence( sec )

local parameters = {nameToy="Guitarra", pathToy="objeto352.png", costToy=_G.PriceToys.guitar, widthToy = 254*1.5 , heightToy = 131*1.5, nextPage = "page_59", indexToy = 9}

playScene( "viewNewToy", parameters )
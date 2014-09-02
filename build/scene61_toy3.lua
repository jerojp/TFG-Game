require( "ControlScene" )

kwkexp:pause( )
kwkafr:pause( )

_G.Level = 5
_G.Phase = 2

local aud = {"exp_afr10.mp3", "exp_afr11.mp3", "exp_afr12.mp3"}
local sub = {"Nuestra misión aquí ha finalizado.",
			"Sí, merece la pena verlos sonreir. Todos los niños que tienen juguetes deberían donarlos cuando ya no los necesiten.",
			"Gracias por el regalo. Bueno, debemos marcharnos, os volveremos a visitar pronto."}

addCharacter(kwkexp, aud, sub)

aud = {"sira_5.mp3", "sira_6.mp3"}
sub = {"Gracias otra vez, los niños se han puesto muy contentos.",
	  "Tienes razón, aquí los más pequeños no tienen nada con lo que jugar porque no se pueden comprar ni un caramelo. Toma este collar que he hecho yo misma como recompensa."}
addCharacter(kwkafr, aud, sub)

aud = {"genius_afr1.mp3"}
sub = {"!Qué collar más bonito!, esto vale una fortuna."}
addCharacter(nil, aud, sub)

local sec = {1, 2, 1, 2, 3, 1}

setSecuence( sec )

local parameters = {nameToy="Unicornio", pathToy="objeto552.png", costToy=_G.PriceToys.unicorn, widthToy = 254*1.5 , heightToy = 131*1.5, nextPage = "page_11", indexToy = 10}

playScene( "viewNewToy", parameters )
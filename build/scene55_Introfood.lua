require( "ControlScene" )

kwkexp:pause( )
kwkafr:pause( )

_G.Level = 5
_G.Phase = 1

local aud = {"exp_afr2.mp3", "exp_afr3.mp3"}
local sub = {"Es un placer ayudaros. Voy a bajar la comida.",
			"Vale. A ver, ¿dónde están la uvas...?"}

addCharacter(kwkexp, aud, sub)

aud = {"sira_1.mp3", "sira_2.mp3"}
sub = {"Hola, bienvenidos a este pueblo. Gracias por traernos comida y agua, los más pequeños lo agradecerán mucho.",
	"!Fantástico! Comienza bajando esas cajas de uvas."}
addCharacter(kwkafr, aud, sub)


local sec = {2, 1, 2, 1}

setSecuence( sec )
playScene( "page_15" )
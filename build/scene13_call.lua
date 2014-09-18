require( "ControlScene" )

girlCall:pause( )
expCall:pause()


local aud = {"exp_sz1.mp3", "exp_sz2.mp3", "exp_sz3.mp3"}
local sub = {"!Hola! ¿Quién es?",
			"Hola Eli, estoy fenomenal, ¿y tú?",
			"Ahora mismo me pongo en marcha hacia Suiza. Adiós y gracias por avisarme."}

addCharacter(expCall, aud, sub)

aud = {"eli_1.mp3", "eli_2.mp3"}
sub = {"Hola, soy Eli tu amiga de la infancia en Suiza. ¿Cómo estás?",
	  "Muy bien, te llamo porque creo que he encontrado algo muy valioso y me he enterado que te has convertido en un explorador. ¿Podrías pasarte por mi casa? Ahora vivo en los Alpes Suizos, trae ropa de abrigo porque hace frío."}

addCharacter(girlCall, aud, sub)

local sec = {1, 2, 1, 2, 1 }
setSecuence( sec )

playScene( "page_14" )
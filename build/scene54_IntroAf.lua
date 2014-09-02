require( "ControlScene" )

kwkexp:pause( )

_G.Level = 5
_G.Phase = 1

local aud = {"exp_afr1.mp3"}
local sub = {"Así que mañana sale un cargamento de ayuda para los más pobres en la región de Malí de Sudáfrica. Es una buena oportunidad para ayudar a los más necesitados y de paso traernos algo bonito para el museo."}
local sec = {1}

addCharacter(kwkexp, aud, sub)
setSecuence( sec )
playScene( "page_55" )
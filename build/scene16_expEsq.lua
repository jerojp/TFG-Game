require( "ControlScene" )
explSkier:pause( )

_G.Level = 2
_G.Phase = 1

local aud = {"exp_sz5.mp3"}
local sub = {"A ver si recuerdo cómo se llega a la casa de Eli. Pero antes debería parar en un pueblo cercano a su casa para realizar algunas compras."}

addCharacter(explSkier, aud, sub)

local sec = {1}
setSecuence( sec )

playScene( "page_17" )
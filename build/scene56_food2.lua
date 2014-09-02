require( "ControlScene" )

kwkexp:pause( )
kwkafr:pause()

_G.Level = 5
_G.Phase = 1

local aud = {"exp_afr4.mp3"}
local sub = {"Vamos a ver. Hemos bajado agua, pan, arroz... Y..., ¿qué era lo otro? Ah, sí, uvas; pero a ver: ¿cómo se escribe esta letra U...?"}
local sec = {1}

addCharacter(kwkexp, aud, sub)
setSecuence( sec )
playScene( "page_57" )
require( "ControlScene" )
gSprites.exp = kwkexp
gSprites.esq = kwkesq
kwkexp:pause( )
kwkesq:pause()

_G.Level = 3
_G.Phase = 2

local aud = {"exp_ps8.mp3", "exp_ps9.mp3"}
local sub = {"!Qué pasada!. Pero no veo el iceberg, debe ser pequeño.",
			"¿Y cómo vamos a llegar hasta allí?"}

addCharacter(kwkexp, aud, sub)

aud = {"esquimal_6.mp3"}
sub = {"No, es enorme, y lo tienes enfrente."}

addCharacter(kwkesq, aud, sub)

local sec = {1, 2, 1}
setSecuence( sec )

playScene( "page_38" )
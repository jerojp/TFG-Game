require( "ControlScene" )

nurse:pause( )

_G.Level = 2
_G.Phase = 2

local aud = {"eli_5.mp3"}
local sub = {"Muy bien, la has acertado qué listo eres. Toma lo que te prometí una caja misteriosa. Escribe la letra E para abrirla."}

addCharacter(nurse, aud, sub)

local sec = {1}
setSecuence( sec )

playScene( "page_17" )
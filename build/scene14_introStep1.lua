require( "ControlScene" )
kwkexp:pause( )

_G.Level = 2
_G.Phase = 1

local aud = {"exp_sz4.mp3"}
local sub = {"Vaya, qué frío hace, y el camino está cubierto de nieve, será mejor que coja unos esquís que hay en esa cabaña para poder llegar a la casa de Eli."}

addCharacter(kwkexp, aud, sub)

local sec = {1}
setSecuence( sec )

playScene( "page_15" )
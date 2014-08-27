require( "ControlScene" )
gSprites.exp = kwkexp

kwkexp:pause( )

_G.Level = 3
_G.Phase = 1

local aud = {"exp_ps1"}
local sub = {"A ver que ponen en las noticias hoy. !Vaya! Han hallado un barco hundido en el Polo Sur. Es la oportunidad perfecta para viajar al Polo Sur en busca de algún tesoro. Genio nos ponemos en marcha."}

addCharacter(kwkexp, aud, sub)

local sec = {1}
setSecuence( sec )

playScene( "page_36" )
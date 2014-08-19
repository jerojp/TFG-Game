require( "ControlScene" )

kwkexp:pause( )
kwkjap:pause( )

_G.Level = 4
_G.Phase = 1

local aud = {"exp_ja7.mp3"}
local sub = {"El guardia está dormido. Entremos sin hacer ruido."}

addCharacter(kwkexp, aud, sub)

local sec = {1}
setSecuence( sec )

playScene( "page_48" )
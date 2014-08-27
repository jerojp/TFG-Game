require( "ControlScene" )
gSprites.exp = kwkexp
kwkexp:pause( )

_G.Level = 4
_G.Phase = 2

local aud = {"exp_ja19.mp3"}
local sub = {"Voy a tomar una foto antes de irnos a los osos panda."}

addCharacter(kwkexp, aud, sub)

local sec = {1}
setSecuence( sec )

playScene( "page_49" )
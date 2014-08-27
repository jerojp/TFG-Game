require( "ControlScene" )
gSprites.exp = kwkexp
kwkexp:pause( )

local aud = {"exp_1.mp3"}
local sub = {"!Que bien! Al fin soy explorador, que contenta se va a poner mi madre cuando se lo diga. Bueno, veamos esta tablet preciosa que me acaban de regalar a ver si encuentro un lugar al que viajar."}
local sec = {1}

addCharacter(kwkexp, aud, sub)
setSecuence( sec )
playScene( "page_10" )
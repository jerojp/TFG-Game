require( "ControlScene" )
kwkboss:pause( )

local aud = {"jefe_2.mp3"}
local sub = {"Vaya, que nombre tan bonito tienes, ¿Y cuántos años tienes?"}
local sec = {1}

addCharacter(kwkboss, aud, sub)
setSecuence( sec )

playScene( "page_62" )
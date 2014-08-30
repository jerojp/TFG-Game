require( "ControlScene" )

kwkboss:pause( )

local aud = {"jefe_1.mp3"}
local sub = {"Hola soy el director de este museo, he oído que quieres trabajar para nosotros ¿Cómo te llamas?"}
local sec = {1}

addCharacter(kwkboss, aud, sub)
setSecuence( sec )
playScene( "page_6" )
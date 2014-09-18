require( "ControlScene" )

kwkboss:pause( )

local aud = {"jefe_3.mp3", "jefe_4.mp3", "jefe_5.mp3"}
local sub = {"Encantado de conocerte y desde este momento ya trabajas para nosotros, te acabas de convertir en un explorador profesional y como tal te recompensaré con monedas cada vez que descubras un nuevo tesoro.",
			"Bueno es hora de ponerse en marcha y quién sabe, quizá te puedas convertir en el explorador más importante del mundo.",
			"Antes de que te marches déjame que te dé una ultima cosa, toma esta Tablet como regalo de bienvenida, puede que te sea útil en tus viajes."}
local sec = {1, 1, 1}

addCharacter(kwkboss, aud, sub)
setSecuence( sec )
playScene( "page_9" )
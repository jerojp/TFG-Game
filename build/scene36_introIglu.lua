require( "ControlScene" )

kwkexp:pause( )
kwkesq:pause()

_G.Level = 3
_G.Phase = 1

local aud = {"exp_ps2.mp3", "exp_ps3.mp3", "exp_ps4.mp3"}
local sub = {"Hola, soy un explorador en busca de aventuras. He leído que se ha hundido un barco por esta región ¿podrías indicarme el lugar?",
			"Genial, muchas gracias. ¿Donde está tu casa? No la veo.",
			"¿Un iglú?, ¿qué es eso? Yo no veo nada."}

addCharacter(kwkexp, aud, sub)

aud = {"esquimal_1.mp3", "esquimal_2.mp3"}
sub = {"Hola, yo me llamo Anori y vivo aquí al lado. Sé dónde está ese barco pero es muy de noche y es peligroso viajar ahora. Ven a mi casa a pasar la noche y mañana iremos en busca de ese barco.",
	 "Es aquel iglú que ves al fondo."}

addCharacter(kwkesq, aud, sub)

local sec = {1, 2, 1, 2, 1}
setSecuence( sec )

playScene( "page_15" )
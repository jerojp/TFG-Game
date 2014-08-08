require( "ControlScene" )
nurse:pause( )
explorer:pause()

_G.Level = 2
_G.Phase = 2

local aud = {"eli_3.mp3", "eli_4.mp3"}
local sub = {"!Cuánto me alegro de verte!, !Cuánto has crecido!",
			"Te propongo una adivinanza, a ver si la aciertas, empieza por la letra E."}

addCharacter(nurse, aud, sub)

aud = {"exp_sz6.mp3"}
sub = {"Sí, y por fin he conseguido convertirme en un explorador, ¿Cuál es tu profesión Eli?"}

addCharacter(explorer, aud, sub)

local sec = {1, 2, 1}
setSecuence( sec )

playScene( "page_15" )
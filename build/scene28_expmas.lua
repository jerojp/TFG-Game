require( "ControlScene" )

kwkexpf:pause( )

--timerStash.timer_PRUEBA = timer.performWithDelay( 5000, act_pr, 1 )

_G.Level = 1
_G.Phase = 1

local img = display.newImageRect( imgDir.."objeto111.png", 47, 16)
img.x = 485; img.y = 297
menuGroup:insert( img )

local aud = {"exp_br5.mp3"}
local sub = {"!AH! Eso era un antifaz. Bueno pues ya solo tengo que entrar a la tienda a comprarlo. Pero, un momento, para pagar con mi tarejta necesito recordar mi firma. Creo que me firma era como la letra A. Creo que la letra A tiene una forma parecida al tejado de una casa."}

addCharacter(kwkexpf, aud, sub)

local sec = {1}
setSecuence( sec )

playScene( "page_29" )
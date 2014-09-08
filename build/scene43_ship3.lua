require( "ControlScene" )

kwkexp:pause( )
kwkesq:pause()

_G.Level = 3
_G.Phase = 2

local img = display.newImageRect( imgDir.."cofreTesoro.png", 476, 436 )
img.x = display.contentCenterX; img.y = display.contentCenterY
menuGroup:insert( img )

local function clearImg( fun )
	-- body
	menuGroup:remove( img )
	img:removeSelf( )
	img = nil
	fun(300)
end

local aud = {"exp_ps10.mp3", "exp_ps11.mp3"}
local sub = {"Al fin hemos encontrado el tesoro. Muchas gracias Anori.",
			"Claro, vendré a visitarte algún día !Adiós!"}

addCharacter(kwkexp, aud, sub)

aud = {"esquimal_7.mp3"}
sub = {"De nada. Vuelve siempre que quieras."}

addCharacter(kwkesq, aud, sub)

local sec = {1, 2, 1}
setSecuence( sec )

local events = {{mytype = "effects", value = {1, clearImg } }, nil, nil}
setEventsControlScene(events)

local parameters = {nameToy="Delfin", pathToy="objeto341.png", widthToy = 150 , heightToy = 101, nextPage = "page_11"}

playScene( "viewNewToy", parameters )
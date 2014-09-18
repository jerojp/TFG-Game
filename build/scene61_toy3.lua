require( "ControlScene" )

kwkexp:pause( )
kwkafr:pause( )

_G.Level = 5
_G.Phase = 2

local function viewImg( fun )
	-- body
	local img
	local function removeElements( event )
		-- body
		img:removeSelf( )
		img = nil
		fun(300)
	end

	img = display.newImageRect( imgDir.."collar.png", 488, 393 )
	img.x = display.contentCenterX; img.y = display.contentCenterY
	img.alpha = 0
	img:scale( 0, 0 )

	audioHandle = audio.loadSound( audioDir.."stars.mp3" )
	transitionStash.collar = transition.to( img, {time = 2000, xScale = 1.0, yScale = 1.0, alpha = 1.0} )
	audio.play( audioHandle, {channel = 1, duration = 2000, fadein = 2000, onComplete = function()
																						audio.dispose( audioHandle ); audioHandle = nil
																						end} )
	timerStash.collar = timer.performWithDelay( 3000, removeElements )
end

local aud = {"exp_afr10.mp3", "exp_afr11.mp3", "exp_afr12.mp3"}
local sub = {"Nuestra misión aquí ha finalizado.",
			"Sí, merece la pena verlos sonreir. Todos los niños que tienen juguetes deberían donarlos cuando ya no los necesiten.",
			"Gracias por el regalo. Bueno, debemos marcharnos, os volveremos a visitar pronto."}

addCharacter(kwkexp, aud, sub)

aud = {"sira_5.mp3", "sira_6.mp3"}
sub = {"Los niños se han puesto muy contentos.",
	  "Sí tienes razón, aquí los más pequeños no tienen nada con lo que jugar porque no se pueden comprar nada. Toma este collar que he hecho yo misma como recompensa."}
addCharacter(kwkafr, aud, sub)

aud = {"genius_afr1.mp3"}
sub = {"!Qué collar más bonito!, esto vale una fortuna."}
addCharacter(nil, aud, sub)

local sec = {1, 2, 1, 2, 3, 1}

setSecuence( sec )

local events = {nil, nil, nil, {mytype = "effects", value = {1, viewImg } }, nil, nil}
setEventsControlScene(events)

local parameters = {nameToy="Locomotora", pathToy="locomotora.png", widthToy = 137 , heightToy = 100, nextPage = "page_11"}

playScene( "viewNewToy", parameters )
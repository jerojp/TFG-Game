require( "ControlScene" )
require("viewGenius")

kwkexp:pause( )
kwksamin:pause()
_G.Level = 1
_G.Phase = 2
--timerStash.timer_PRUEBA = timer.performWithDelay( 5000, act_pr, 1 )
--_G.Subtitle = false
--_G.AutoNextPage = true

local audioHandle
local gpGenius = createGenius( )
gpGenius:scale( 0.3, 0.3 )
gpGenius:translate( display.contentWidth - (gpGenius.Tablet.contentWidth*1.85) , display.contentHeight - (gpGenius.Tablet.contentHeight *1.10) )
gpGenius.alpha = 0

local function viewImg( fun )
	-- body
	local img
	local function removeElements( event )
		-- body
		img:removeSelf( )
		img = nil
		fun(300)
	end

	img = display.newImageRect( imgDir.."jarronInca.png", 391, 532 )
	img.x = display.contentCenterX; img.y = display.contentCenterY
	img.alpha = 0
	img:scale( 0, 0 )

	audioHandle = audio.loadSound( audioDir.."stars.mp3" )
	transitionStash.jarron = transition.to( img, {time = 2000, xScale = 1.0, yScale = 1.0, alpha = 1.0} )
	audio.play( audioHandle, {channel = 1, duration = 2000, fadein = 2000, onComplete = function()
																						audio.dispose( audioHandle ); audioHandle = nil
																						end} )
	timerStash.jarron = timer.performWithDelay( 3000, removeElements )
end

local function inicDialog( )
	-- body
	local aud = {"exp_br9.mp3", "exp_br10.mp3"}
	local sub = {"Ha sido un placer. Podrías indicarme la dirección para encontrar esta zona.",
			"Muchas gracias, mi jefe se va a poner muy contento."}

	addCharacter(kwkexp, aud, sub)

	local aud = {"samin_br4.mp3", "samin_br5.mp3"}
	local sub = {"Gracias por haberme ayudado, ahora los animales de la selva podrán descansar libremente.",
			"Claro, pero allí ya no queda nada. Tuve que retirar ese tesoro para evitar que las máquinas lo destruyeran. Toma, te lo doy como recompensa por haberme ayudado"}

	addCharacter(kwksamin, aud, sub)

	aud = {"genio_br1.mp3"}
	sub = {"Vaya, así que has conseguido el tesoro. Se lo entregaré ahora mismo al jefe."}

	addCharacter(gpGenius.genius, aud, sub, gpGenius)

	local sec = {2, 1, 2, 1, 3}
	setSecuence( sec )

	local events = {nil, nil, {mytype = "effects", value = {1, viewImg } }, nil, nil}
	setEventsControlScene(events)

	local parameters = {nameToy="Abeja", pathToy="objeto141.png", widthToy = 137 , heightToy = 98, nextPage = "page_11"}

	playScene( "viewNewToy", parameters )
end

local function onCompleteTransition( event )
        -- body
        --[[if ( audio.isChannelPlaying( 2 ) ) then
          audio.stop( 2 )
        end
        audio.dispose( audioHandle )
        audioHandle = nil
        ]]--
        inicDialog()
end

local function inicTransition( event )
	-- body
	--audioHandle = audio.loadSound( audioDir.."samba.mp3" )
	--audio.play( audioHandle, {channel = 2} )
	transitionStash.machine = transition.to( kwkmachine, {  time=1000, x= kwkmachine.x , y=kwkmachine.y + 200, onComplete=onCompleteTransition} )
end

HoleUp.alpha = 1
holeD.alpha = 1
timerStash.timer_machineDes = timer.performWithDelay( 500, inicTransition, 1 )


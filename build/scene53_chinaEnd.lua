require( "ControlScene" )
require("viewGenius")

kwkexp:pause( )

--timerStash.timer_PRUEBA = timer.performWithDelay( 5000, act_pr, 1 )
--_G.Subtitle = false
--_G.AutoNextPage = true
_G.Level = 4
_G.Phase = 2

local gpGenius = createGenius( )
gpGenius:scale( 0.3, 0.3 )
gpGenius:translate( display.contentWidth - (gpGenius.Tablet.contentWidth*1.85) , display.contentHeight - (gpGenius.Tablet.contentHeight *1.10) )
gpGenius.alpha = 0
menuGroup:insert( gpGenius )
gpGenius.genius:pause( )

local audioHandle
local cam = display.newRect( 0, 0, display.contentWidth , display.contentHeight )
cam:setFillColor( 250 )
cam.alpha = 0

local function onFinalizeScene( event )
	-- body
	local aud = {"exp_ja20.mp3"}
	local sub = {"Aunque..., Ali, el jefe se va a enfadar porque no hemos encontrado ningún tesoro.."}

	addCharacter(kwkexp, aud, sub)

	aud = {"genio_ja3.mp3"}
	sub = {"Al contrario. La acción que has hecho de liberar a un animal preso es más valioso que cualquier premio. Así que aquí tienes tu recompensa."}

	addCharacter(gpGenius.genius, aud, sub, gpGenius)

	local sec = {1, 2}
	setSecuence( sec )

	local parameters = {nameToy="Burro", pathToy="objeto541.png", widthToy = 131 , heightToy = 111, nextPage = "page_11"}

	playScene( "viewNewToy", parameters )

end

function onCompleteSoundCamara(event)
	-- body
	audio.dispose( audioHandle )
	audioHandle = nil
end

local function onCompletePhoto( event )
		-- body
	transitionStash.takePhoto2 = transition.to( cam, {time = 300, alpha = 0, onComplete=onFinalizeScene} )	
end

local function takePhoto( event )
	-- body
	audioHandle = audio.loadSound( audioDir.."camara.mp3" )
	audio.play( audioHandle, {channel = 1, onComplete = onCompleteSoundCamara} )
	transitionStash.takePhoto1 = transition.to( cam, {time = 300, alpha = 1, onComplete=onCompletePhoto} )
end

timerStash.photo = timer.performWithDelay( 700, takePhoto, 1 )